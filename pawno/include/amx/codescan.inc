// Copyright (C) 2016 Y_Less
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

#if defined CODESCAN_INC
	#endinput
#endif
#define CODESCAN_INC

/*

// Example:

forward TailCall_FoundCallback(m[CodeScanner])

main() {
	new scanner[CodeScanner];
	CodeScanInit(scanner);
	
	new csm0[CodeScanMatcher];
	CodeScanMatcherInit(csm0, &TailCall_FoundCallback);
	CodeScanMatcherPattern(csm0,
		OP(PUSH_C, ???)
		OP(CALL,   &MyFunc)
		OP(RETN)
	);
	CodeScanAddMatcher(scanner, csm0);
	
	// Add other matcher patterns here.
	
	// Run all the scanners in parallel.
	CodeScanRun(scanner);
}

public TailCall_FoundCallback(m[CodeScanner]) {
	// Do something with the found address (of the START of the match), and the
	// stack size (of the END of the match) - different for reasons...
}

// Create a default call for this function, so that we can include it in the AMX
// and take the address in "OP".  Note that you do NOT need to do this for
// scanner callbacks if you only use their address in "CodeScanMatcherInit".
#define CALL@MyFunc MyFunc(0, "")
stock MyFunc(a, b[], ...) {
	// Normal function.
}

*/

#include <core>

#include "frame_info"
#include "disasm"
#include "asm"
#include "addressof"

#define SCANNER_FAIL_ON_INVALID (1)
#define SCANNER_IGNORE_NOP      (2)
#define SCANNER_IGNORE_BREAK    (4)
#define SCANNER_NAME_FUNCTIONS  (8)
#define SCANNER_IGNORE_HALT     (16)
#define SCANNER_IGNORE_BOUNDS   (32)
#define SCANNER_HAS_USER_DATA   (64)

#define O@I_ (0) // Type integer.
#define O@U_ (1) // Type unknown (???).
#define O@F_ (2) // Type function (&func).
#define O@O_ (4) // Type opcode.
#define O@S_ (5) // Type skipped.

#define OP_TYPE_INTEGER_  (O@I_) // Type integer.
#define OP_TYPE_UNKNOWN_  (O@U_) // Type unknown (???).
#define OP_TYPE_FUNCTION_ (O@F_) // Type function (&func).
#define OP_TYPE_OPCODE_   (O@O_) // Type opcode.
#define OP_TYPE_SKIP_     (O@S_) // Type skipped.

// If we can determine a function's name, we can determine if it is a public or
// not.  If we can't name it, it is a normal one.  However, if naming is skipped
// then we will have no idea what type it is.
#define SCANNER_FUNC_PUBLIC   (1)
#define SCANNER_FUNC_OTHER    (2)
#define SCANNER_FUNC_AUTOMATA (3)
#define SCANNER_FUNC_HALT     (4)
#define SCANNER_FUNC_UNKNOWN  (5)
#define SCANNER_FUNC_AUTOMATA_NO_NAME (7)
#define SCANNER_FUNC_HALT_NO_NAME     (8)

// The "OP()" macro is used to easilly define code patterns to scan for:
//   
//   new csm[CodeScanMatcher];
//   CodeScanMatcherInit(csm, &callback);
//   CodeScanMatcherPattern(csm,
//       OP(CONST_PRI, 42)
//       OP(ADD_C,     ???)
//       OP(CALL,      &my_func)
//   )
//   
// Any function that you want to take the address of in this way must have its
// call pattern defined as:
//   
//   #define CALL@my_func my_func(0, "hi", false)
//   
// Because otherwise a) the code can't guarantee that the function will be in
// the final amx, and b) we need a call to it from which to extract the addr.
// 
// You can use this style explcitly within an "OP" scanner, or there is a new
// dedicated keyword for it - "addressof(func)" (note the lack of "&" there).
// 
#define OP(%0) ,(_:O@T_:O@O_),(Opcode:O@X_:O@Y_:O@W_:$OP_%0)
#define OP_%0\32;%1) OP_%0%1)

#define O@X_:%9$%0,%1,%2) %0),(_:O@1_:O@2_:O@3_:$%1|||,%2)
#define O@Y_:%9$%0,%1)    %0),(_:O@1_:O@2_:O@3_:$%1|||)
#define O@Z_:%9$%0)       %0)
#define O@W_:%9$%0)       %0)

#define O@T_:O@O_),(Opcode:O@X_:O@Y_:O@W_:$OP_???%0) O@S_),(0)

#define O@1_:%9$%0???%1|||%2) O@U_ ),(_:O@X_:O@Y_:O@Z_:$0%2)
#define O@2_:%9$%0&%1|||%2)   O@F_),(O@A_()?(((CALL@%1),O@V_)?1:2):_:O@X_:O@Y_:O@Z_:$(O@V_)%2)
#define O@3_:%9$%1|||%2)      O@I_ ),(_:O@X_:O@Y_:O@Z_:$(%1)%2)

#if !defined cellbytes
	#define cellbytes (cellbits / 8)
#endif

#if !defined CODE_SCAN_MAX_PATTERN
	#define CODE_SCAN_MAX_PATTERN (16)
#endif
#define CODE_SCAN_MAX_PATTERN_ARRAY (CODE_SCAN_MAX_PATTERN * 4)
#define CODE_SCAN_MAX_HOLES         (CODE_SCAN_MAX_PATTERN / 2)

#if !defined CODE_SCAN_MAX_PARALLEL
	#define CODE_SCAN_MAX_PARALLEL (2)
#endif

#if !defined CODE_SCAN_MAX_JUMP_TARGETS
	#define CODE_SCAN_MAX_JUMP_TARGETS (32)
#endif

// All the information for scanning through an AMX and extracting lots of nice
// information about it.
enum CodeScanner {
	CodeScanMatch_func,       // Start of the containing function.
	CodeScanMatch_size,       // Size of the match.
	CodeScanMatch_type,       // Public, normal, automata, etc.
	CodeScanMatch_heap,       // At the point of this scanner.
	CodeScanMatch_stack,      // At the point of this scanner.
	CodeScanMatch_params,     // Likely unknown statically.
	CodeScanMatch_cip,        // The point of the pattern match.
	CodeScanMatch_holes[CODE_SCAN_MAX_HOLES], // Results of "???"s.
	CodeScanMatch_hole_count, // How many holes were seen.
	CodeScanMatch_name[32 char],
	CodeScanner_first,
	CodeScanner_minn,
	CodeScanner_jump_switch[CODE_SCAN_MAX_JUMP_TARGETS], // For "CASETBL" not regular jumps.
	CodeScanner_jump_target[CODE_SCAN_MAX_JUMP_TARGETS], // Zero when this slot is available.
	CodeScanner_jump_stack [CODE_SCAN_MAX_JUMP_TARGETS], // Sizes at the time of the jump.
	CodeScanner_jump_heap  [CODE_SCAN_MAX_JUMP_TARGETS], // Sizes at the time of the jump.
	CodeScanner_state,
	CodeScanner_param
}

enum CodeScanMatcher {
	CodeScanMatcher_func,      // A pointer to the callback.
	CodeScanMatcher_user_data, // User data to pass to their callback.
	CodeScanMatcher_code[CODE_SCAN_MAX_PATTERN_ARRAY], // The code to look for.
	CodeScanMatcher_len,
	CodeScanMatcher_offset[CODE_SCAN_MAX_PARALLEL], // Where the current scanner is in this code.
	CodeScanMatcher_start[CODE_SCAN_MAX_PARALLEL],
	CodeScanMatcher_holeidx[CODE_SCAN_MAX_PARALLEL],
	CodeScanMatcher_holes[CODE_SCAN_MAX_PARALLEL * CODE_SCAN_MAX_HOLES],
	CodeScanMatcher_next,      // The next match array.
	CodeScanMatcher_flags      // Customisation.
}

// This macro is to let anyone use `&callback` for a scanner callback without
// having to define the `CALL@...` macro for the required parameters (since we
// know to call scanner callbacks in this code).
#define addressof_ScannerCallback_(%1) (O@A_()?(((%1((gCodeScanCallback_match))),O@V_)?1:2):(O@V_))

stock
	gCodeScanCallback_match[CodeScanner];

static stock
	gOP_NOP,
	gOP_CASETBL,
	gFirstProc,
	gHdr[AMX_HDR],
	gBase,
	gDat;

static stock bool:CodeScanCheckJumpTarget(cip, deloc, &stk, &hea, jumpTargets[CodeScanner]) {
	for (new num = jumpTargets[CodeScanner_minn], sip; num--; ) {
		if ((sip = jumpTargets[CodeScanner_jump_switch][num])) {
			for (new count = ReadAmxMemory(sip + cellbytes) + 1; count; --count) {
				if (ReadAmxMemory(sip + (2 * cellbytes) * count) == deloc) {
					stk = jumpTargets[CodeScanner_jump_stack][num],
					hea = jumpTargets[CodeScanner_jump_heap][num];
					return;
				}
			}
		} else if (jumpTargets[CodeScanner_jump_target][num] == cip) {
			jumpTargets[CodeScanner_minn] = num,
			stk = jumpTargets[CodeScanner_jump_stack][num],
			hea = jumpTargets[CodeScanner_jump_heap][num];
			return;
		} else if (jumpTargets[CodeScanner_jump_target][num] < cip) {
			jumpTargets[CodeScanner_minn] = num;
			return;
		}
	}
}

static stock CodeScanResetJumpTargets(jumpTargets[CodeScanner]) {
	jumpTargets[CodeScanner_minn] = 0;
}

static stock CodeScanAddJumpTarget(cip, stk, hea, jumpTargets[CodeScanner], next, sip = 0) {
	new
		num = jumpTargets[CodeScanner_minn];
	// Add an address to the list of addresses known to be jumped to.  We keep
	// this list sorted in a very simple fashion.  Since 99% of calls to this
	// code will be from control structures, their layout is already well
	// defined.  In the rare case that they aren't, this is probably from a
	// `goto` (and a `goto` that jumps outside a control structure at that),
	// thus we can optimise for the common case and fall back on searching and
	// shifting after that.  Check that the last address on the stack is GREATER
	// than the address being pushed.
	if (num && jumpTargets[CodeScanner_jump_target][num - 1] <= cip) {
		// We only ever jump forward.  Thus if we get to this point we know
		// `cip` is in the future, and `CodeScanner_jump_target` is before
		// `cip`.  Thus there is one possibility left -
		// `CodeScanner_jump_target` is in the past and no longer needs checking
		// for.
		while (num-- && jumpTargets[CodeScanner_jump_target][num] < next) {
			// Just forget about this target.  NOT `<=` because at this point
			// we haven't yet checked this address as a jump target - we are
			// still dealing with the effects of the previous instruction.
		}
		jumpTargets[CodeScanner_minn] = next = ++num;
		// Check this entry doesn't already exist.
		while (num--) {
			if (jumpTargets[CodeScanner_jump_target][num] == cip) {
				return;
			}
		}
		for (num = next; num-- && jumpTargets[CodeScanner_jump_target][num] < cip; next--) {
			jumpTargets[CodeScanner_jump_switch][next] = jumpTargets[CodeScanner_jump_switch][num],
			jumpTargets[CodeScanner_jump_target][next] = jumpTargets[CodeScanner_jump_target][num],
			jumpTargets[CodeScanner_jump_stack][next] = jumpTargets[CodeScanner_jump_stack][num],
			jumpTargets[CodeScanner_jump_heap][next] = jumpTargets[CodeScanner_jump_heap][num];
		}
		++num;
	}
	if (num < CODE_SCAN_MAX_JUMP_TARGETS) {
		++jumpTargets[CodeScanner_minn],
		jumpTargets[CodeScanner_jump_switch][num] = sip,
		jumpTargets[CodeScanner_jump_target][num] = cip,
		jumpTargets[CodeScanner_jump_stack][num] = stk,
		jumpTargets[CodeScanner_jump_heap][num] = hea;
	} else {
		printf("CodeScan Error: Could not add jump target to scanner.");
		printf(" - Try `#define CODE_SCAN_MAX_JUMP_TARGETS (64)` or greater.");
	}
}

static stock CodeScanAddSwitchTarget(const dctx[DisasmContext], stk, hea, jumpTargets[CodeScanner], next) {
	new
		sip = DisasmGetOperand(dctx) - gBase,
		codepos = sip + gHdr[AMX_HDR_DAT] - gHdr[AMX_HDR_COD];
	if (codepos < 0 || codepos > gHdr[AMX_HDR_DAT] || ReadAmxMemory(sip) != gOP_CASETBL) {
		// Can happen when we parse "RelocateOpcodeNow" because it has an
		// explicit "#emit switch 0" in.
		return;
	}
	// Find the largest address in the switch.  This is what we'll use for
	// inserting it in to the sorted list of targets.  Thus it can be easily
	// removed once out of scope, and doesn't have a different lifespan to
	// normal jumps.
	new
		largest = cellmin;
	for (new num = ReadAmxMemory(sip + cellbytes) + 1; num; --num) {
		largest = max(ReadAmxMemory(sip + (2 * cellbytes) * num), largest);
	}
	CodeScanAddJumpTarget(largest - gBase, stk, hea, jumpTargets, next, sip);
}

static stock CodeScanReset(cs[CodeScanMatcher], &next) {
	static
		lReset[CODE_SCAN_MAX_PARALLEL];
	next = cs[CodeScanMatcher_next],
	cs[CodeScanMatcher_offset] = lReset,
	cs[CodeScanMatcher_holeidx] = lReset;
	if (!cs[CodeScanMatcher_func]) {
		cs[CodeScanMatcher_len] = 0;
	}
}

stock CodeScanAddMatcher(scanner[CodeScanner], searcher[CodeScanMatcher]) {
	searcher[CodeScanMatcher_next] = scanner[CodeScanner_first],
	scanner[CodeScanner_first] = ref(searcher);
}

stock CodeScanMatcherInit_(searcher[CodeScanMatcher], address, flags = SCANNER_IGNORE_NOP | SCANNER_IGNORE_BOUNDS | SCANNER_IGNORE_BREAK | SCANNER_IGNORE_HALT) {
	// This used to look the function up by name from the public functions
	// table, but that was very silly since we already had code in this exact
	// file to get the address of ANY function at run-time (`addressof`).  The
	// only difference between the normal `addressof` and the one used here is
	// that because we know exactly what sort of functions we are expecting, we
	// know exactly what parameters they require to construct the fake call, so
	// we can do away with the `CALL@...` macro requirement for defining the
	// standard call pattern.  This also means that we actually ensure that the
	// passed function has the correct shape.
	searcher[CodeScanMatcher_func] = address,
	searcher[CodeScanMatcher_flags] = flags & ~SCANNER_HAS_USER_DATA,
	searcher[CodeScanMatcher_next] = -1,
	searcher[CodeScanMatcher_len] = 0,
	searcher[CodeScanMatcher_user_data] = 0,
	CodeScanReset(searcher, flags);
}

stock CodeScanMatcherData(searcher[CodeScanMatcher], val) {
	// Use `ref()` to pass an array.
	searcher[CodeScanMatcher_flags] |= SCANNER_HAS_USER_DATA,
	searcher[CodeScanMatcher_user_data] = val;
}

// Will not call the function because the check will fail, but will not compile
// if the function doesn't exist, while still passing it in as a string.
#define CodeScanMatcherInit(%0,&%1) CodeScanMatcherInit_((%0),addressof_ScannerCallback_(%1))
#define CodeScanMatcherInit_(%0,addressof_ScannerCallback_(%1,%2)) CodeScanMatcherInit_(%0,addressof_ScannerCallback_(%1),%2)

stock CodeScanMatcherPattern_(searcher[CodeScanMatcher], {Opcode, Float, _}:...) {
	new
		len = numargs() - 1;
	if (len > CODE_SCAN_MAX_PATTERN_ARRAY) {
		return -1;
	}
	if (len & 0x01) {
		// Not a multiple of 2 in the scanner.
		return -2;
	}
	for (new i = 0; i != len; ) {
		new
			optype = getarg(i + 1),
			Opcode:op = Opcode:getarg(i + 2);
		searcher[CodeScanMatcher_code][i + 0] = optype;
		searcher[CodeScanMatcher_code][i + 1] = _:RelocateOpcode(op);
		i += 2;
		switch (optype) {
			case OP_TYPE_OPCODE_: {
				new opcount = GetOpcodeInstructionParameters(op);
				for (new partype; i != len; )
				{
					partype = getarg(i + 1);
					switch (partype) {
						case OP_TYPE_INTEGER_, OP_TYPE_UNKNOWN_, OP_TYPE_FUNCTION_: {
							// Got an unexpected parameter.
							if (opcount == 0) {
								return i / 2 + 1;
							}
							// Decrement the remaining number of parameters.
							// The variable OPs like `CASETBL` have negative
							// parameter counts, so will never not match.
							--opcount;
							searcher[CodeScanMatcher_code][i + 0] = partype;
							searcher[CodeScanMatcher_code][i + 1] = getarg(i + 2);
							i += 2;
						}
						default: {
							break;
						}
					}
				}
				// Missing a required (non-optional) parameter.
				if (opcount > 0) {
					return i / 2 + 1;
				}
			}
			case OP_TYPE_SKIP_: {
			}
			default: {
				// Incorrect parameter type.  Return the op where it happened.
				return i / 2 + 1;
			}
		}
	}
	searcher[CodeScanMatcher_len] = len;
	// No error.
	return 0;
}

// Note the lack of trailing comma.  This is to make the code patterns work.
#define CodeScanMatcherPattern(%0, CodeScanMatcherPattern_(%0

static stock CodeScanDeref(v) {
	static
		lFakeMatcher[CodeScanMatcher];
	#pragma unused v
	#emit load.s.pri 12 // First argument.
	#emit stor.s.pri 16 // Secret argument.
	#emit retn
	return lFakeMatcher; // Make compiler happy, and teach it the array return.
}

static stock bool:CodeScanCheck(Opcode:op, const dctx[DisasmContext], cs[CodeScanMatcher], fctx[CodeScanner], &next) {
	// Returns an address of a callback if it passes.
	if (!cs[CodeScanMatcher_len]) {
		return
			next = cs[CodeScanMatcher_next],
			false;
	}
	new
		bool:zero = true,
		off = cs[CodeScanMatcher_flags];
	if (off) {
		// To deal with differences in different compilation modes, we just mark
		// these opcodes as fully ignorable (because they are mostly used for
		// debugging and not real user code).
		switch (op) {
			case OP_NOP: {
				if (off & SCANNER_IGNORE_NOP) {
					return
						next = cs[CodeScanMatcher_next],
						false;
				}
			}
			case OP_BOUNDS: {
				if (off & SCANNER_IGNORE_BOUNDS) {
					return
						next = cs[CodeScanMatcher_next],
						false;
				}
			}
			case OP_BREAK: {
				if (off & SCANNER_IGNORE_BREAK) {
					return
						next = cs[CodeScanMatcher_next],
						false;
				}
			}
			case OP_HALT: {
				if (off & SCANNER_IGNORE_HALT) {
					return
						next = cs[CodeScanMatcher_next],
						false;
				}
			}
		}
	}
	new
		cnt = DisasmGetNumOperands(dctx),
		len = cs[CodeScanMatcher_len];
	for (new idx = 0; idx != CODE_SCAN_MAX_PARALLEL; ++idx) {
		off = cs[CodeScanMatcher_offset][idx];
		// Ensure that only one of the parallel scanners starts from the
		// beginning on each instruction.
		if (off) {
		} else if (zero) {
			// Get the start point of this match.
			cs[CodeScanMatcher_start][idx] = DisasmGetCurIp(dctx),
			zero = false;
		} else {
			continue;
		}
		if (cs[CodeScanMatcher_code][off] == OP_TYPE_SKIP_) {
			off += 2;
			if (off == len) {
				return
					memcpy(fctx[CodeScanMatch_holes], cs[CodeScanMatcher_holes], idx * CODE_SCAN_MAX_HOLES, cs[CodeScanMatcher_holeidx][idx] * cellbytes, CODE_SCAN_MAX_HOLES),
					fctx[CodeScanMatch_hole_count] = cs[CodeScanMatcher_holeidx][idx],
					fctx[CodeScanMatch_cip] = cs[CodeScanMatcher_start][idx],
					fctx[CodeScanMatch_size] = DisasmGetNextIp(dctx) - cs[CodeScanMatcher_start][idx],
					true;
			} else if (cs[CodeScanMatcher_code][off] == OP_TYPE_OPCODE_ && Opcode:cs[CodeScanMatcher_code][off + 1] == op) {
				// Found the match after the current "missing" instruction.
				goto CodeScanCheck_pass;
			} else {
				// The "== op" check is done twice because in this case we don't
				// want to fail the scanner if it doesn't match.
				continue;
			}
		}
		if (cs[CodeScanMatcher_code][off] == OP_TYPE_OPCODE_ && Opcode:cs[CodeScanMatcher_code][off + 1] == op) {
CodeScanCheck_pass:
			// Check if there are enough parameters for this opcode.
			off += 2;
			for (new i = 0; i != cnt; ++i) {
				switch (cs[CodeScanMatcher_code][off++]) {
					// Because we now abstract relocations to the disasm system,
					// we don't need to differentiate between fixed parameters
					// and function parameters any more - they are always fully
					// resolved.
					case OP_TYPE_INTEGER_, OP_TYPE_FUNCTION_: {
						if (cs[CodeScanMatcher_code][off++] != DisasmGetOperandReloc(dctx, i)) {
							goto CodeScanCheck_fail;
						}
					}
					case OP_TYPE_UNKNOWN_: {
						// Save the parameter.
						++off,
						cs[CodeScanMatcher_holes][idx * CODE_SCAN_MAX_HOLES + cs[CodeScanMatcher_holeidx][idx]++] = DisasmGetOperandReloc(dctx, i);
					}
					case OP_TYPE_OPCODE_, OP_TYPE_SKIP_: {
						goto CodeScanCheck_fail;
					}
				}
			}
			if (off == len) {
				// Get the address of the START of the match.
				return
					memcpy(fctx[CodeScanMatch_holes], cs[CodeScanMatcher_holes][idx * CODE_SCAN_MAX_HOLES], 0, cs[CodeScanMatcher_holeidx][idx] * cellbytes, CODE_SCAN_MAX_HOLES),
					fctx[CodeScanMatch_hole_count] = cs[CodeScanMatcher_holeidx][idx],
					fctx[CodeScanMatch_cip] = cs[CodeScanMatcher_start][idx],
					fctx[CodeScanMatch_size] = DisasmGetNextIp(dctx) - cs[CodeScanMatcher_start][idx],
					true;
			} else switch (cs[CodeScanMatcher_code][off]) {
				case OP_TYPE_INTEGER_, OP_TYPE_FUNCTION_, OP_TYPE_UNKNOWN_: {
					// Parameters remaining, none expected.
					goto CodeScanCheck_fail;
				}
				default: {
					// Out of parameters to check but still looking correct.
					cs[CodeScanMatcher_offset][idx] = off;
					continue;
				}
			}
		}
CodeScanCheck_fail:
		// The parameter is wrong.
		cs[CodeScanMatcher_holeidx][idx] = cs[CodeScanMatcher_offset][idx] = 0;
	}
	return
		next = cs[CodeScanMatcher_next],
		false;
}

static stock bool:CodeScanGetFuncName(addr, name[]) {
	// The "name" parameter is longer than 32 (which is the maximum function
	// name length normally) beacause we append states to some.
	// Name not found.
	new
		index = GetPublicIndexFromAddress(addr);
	if (index < 0) {
		return
			name[0] = 0,
			false;
	}
	// This code will not return great results for public functions with states.
	return
		GetPublicNameFromIndex(index, name, 32),
		true;
}

static stock bool:CodeScanStepInternal(dctx[DisasmContext], csState[CodeScanner], &parseState, &parseParam) {
	// Loop over the data.  Since our end condition is "out of data", we know
	// that any "false" returns are because of invalid data since the "< 0"
	// check is also the only other way that "false" can be returned and we pre-
	// empt that one.
	switch (DisasmNext(dctx)) {
		case DISASM_OK: {
			new
				stk = csState[CodeScanMatch_stack],
				hea = csState[CodeScanMatch_heap],
				cip = DisasmGetCurIp(dctx),
				Opcode:op = DisasmGetOpcode(dctx);
			// The compiler sometimes inserts extra instructions like "NOP" and
			// "BREAK" for debugging and padding (as do we) - maybe ignore them.
			CodeScanCheckJumpTarget(cip, cip + gBase, stk, hea, csState);
			switch (op) {
				case OP_HALT: {
					if (parseState == 4) {
						csState[CodeScanMatch_type] = SCANNER_FUNC_HALT_NO_NAME,
						csState[CodeScanMatch_func] = cip,
						stk = hea = 0,
						CodeScanResetJumpTargets(csState);
					}
				}
				case OP_PROC: {
					// This is the start of a new function.  The only functions
					// that don't start like this are the automata stubs.
					csState[CodeScanMatch_type] = SCANNER_FUNC_UNKNOWN,
					csState[CodeScanMatch_func] = cip,
					CodeScanResetJumpTargets(csState),
					stk = hea = parseState = 0;
				}
				case OP_LOAD_PRI: {
					// If we are not in the main functions yet and this is the
					// first instruction seen, then it is the start of an
					// automata function stub.
					if (parseState == 4) {
						csState[CodeScanMatch_type] = SCANNER_FUNC_AUTOMATA_NO_NAME,
						csState[CodeScanMatch_func] = cip,
						stk = hea = 0,
						CodeScanResetJumpTargets(csState);
					}
				}
				case OP_PUSH_PRI, OP_PUSH_ALT, OP_PUSH_R, OP_PUSH_S, OP_PUSH, OP_PUSH_ADR: {
					if (stk != cellmin) {
						stk += cellbytes;
					}
					parseState = 0;
				}
				case OP_STACK: {
					// The stack grows down, but our count is positive.
					if (stk != cellmin) {
						stk -= DisasmGetOperand(dctx);
					}
					parseState = 0;
				}
				case OP_HEAP: {
					if (hea != cellmin) {
						hea += DisasmGetOperand(dctx);
					}
					parseState = 0;
				}
				case OP_POP_PRI, OP_POP_ALT: {
					if (stk != cellmin) {
						stk -= cellbytes;
					}
					parseState = 0;
				}
				case OP_CALL, OP_CALL_PRI: {
					// Remove all the function parameters.
					if (parseState == 3) {
						stk -= parseParam;
					}
					parseState = 0;
				}
				case OP_PUSH_C: {
					// The "+ cellbytes" is because when calling a function, the
					// parameter is the number of bytes pushed, not including
					// this one, with that one implicitly popped on return.
					parseParam = DisasmGetOperand(dctx) + cellbytes;
					if (stk != cellmin) {
						stk += cellbytes,
						parseState = 3;
					}
				}
				// There is a code-get pattern of:
				// 
				//   LCTRL 5
				//   ADD.C n
				//   SCTRL 4
				// 
				// Which adjusts the stack to the correct size after "goto".  We
				// have to deal with that explcitly.  Note that the "ADD.C" may
				// be missing if there are no variables currently in scope.
				case OP_LCTRL: {
					if (DisasmGetOperand(dctx) == 5) {
						parseParam = 0;
						parseState = 1;
					} else {
						parseState = 0;
					}
				}
				case OP_ADD_C: {
					if (parseState == 1) {
						parseParam = -DisasmGetOperand(dctx),
						parseState = 2;
					} else {
						parseState = 0;
					}
				}
				case OP_SCTRL: {
					// This is the tricky one, since it can mess up the stack in
					// strange ways.  Deal with the case where it comes from
					// "goto", even though that is generally considered bad.
					switch (DisasmGetOperand(dctx)) {
						case 2: {
							hea = cellmin;
						}
						case 4: {
							switch (parseState) {
								case 1: {
									stk = 0;
								}
								case 2: {
									stk = parseParam;
								}
								default: {
									stk = cellmin;
								}
							}
						}
						case 5: {
							stk = cellmin;
						}
					}
					parseState = 0;
				}
				case OP_JUMP, OP_JZER, OP_JNZ, OP_JEQ, OP_JNEQ, OP_JLESS, OP_JLEQ, OP_JGRTR, OP_JGEQ, OP_JSLESS, OP_JSLEQ, OP_JSGRTR, OP_JSGEQ: {
					// Add a jump target.  These require relocation as they are
					// translated to absolute RAM locations.  "DisasmNeedReloc"
					// will return "true", but we don't need to call it.
					// Relocate it relative to "dat" not "cod" for simpler
					// comparisons - just see if the read address matches
					// instead of the true code address.
					//   
					//   val = val - (base + cod) + (cod - dat);
					//   val = val - base - cod + cod - dat;
					//   val = val - base - dat;
					//   val = val - (base + dat);
					//   base = base + dat;
					//   val = val - base;
					//   
					// Only jumps that go forwards.
					parseParam = DisasmGetOperand(dctx) - gBase,
					parseState = 0;
					if (parseParam > cip) {
						CodeScanAddJumpTarget(parseParam, stk, hea, csState, DisasmGetNextIp(dctx));
					}
				}
				case OP_JREL: {
					// Add a jump target.  Only jumps that go forwards.
					parseParam = DisasmGetOperand(dctx) + cip,
					parseState = 0;
					if (parseParam > cip) {
						CodeScanAddJumpTarget(parseParam, stk, hea, csState, DisasmGetNextIp(dctx));
					}
				}
				case OP_SWITCH: {
					// Add a jump target.  These are always forwards.
					CodeScanAddSwitchTarget(dctx, stk, hea, csState, DisasmGetNextIp(dctx)),
					parseState = 0;
				}
				default: {
					parseState = 0;
				}
			}
			csState[CodeScanMatch_stack] = stk,
			csState[CodeScanMatch_heap] = hea;
		}
		case DISASM_DONE: {
			return false;
		}
		case DISASM_NOP: {
			parseState = 0;
		}
	}
	return true;
}

stock bool:CodeScanStep(dctx[DisasmContext], csState[CodeScanner]) {
	return CodeScanStepInternal(dctx, csState, csState[CodeScanner_state], csState[CodeScanner_param]);
}

static stock CodeScanCall(const cs[CodeScanMatcher], csState[CodeScanner]) {
	// If I wrote way more assembly I could get away with not calling
	// `CodeScanDeref(cur)` below, and not need to assign `param` to a variable
	// before pushing it.  But I'm not going to - it isn't worth the effort.
	new
		func = cs[CodeScanMatcher_func];
	if (cs[CodeScanMatcher_flags] & SCANNER_HAS_USER_DATA) {
		new
			param = cs[CodeScanMatcher_user_data];
		#emit PUSH.S     param
		#emit PUSH.S     csState
		#emit PUSH.C     8
		#emit LCTRL      6
		#emit ADD.C      36
		#emit LCTRL      8
		#emit PUSH.pri
		#emit LOAD.S.pri func
		#emit SCTRL      6
		#emit STOR.S.pri func
	} else {
		#emit PUSH.S     csState
		#emit PUSH.C     4
		#emit LCTRL      6
		#emit ADD.C      36
		#emit LCTRL      8
		#emit PUSH.pri
		#emit LOAD.S.pri func
		#emit SCTRL      6
		#emit STOR.S.pri func
	}
	return func;
}

stock bool:CodeScanRun(csState[CodeScanner]) {
	if (csState[CodeScanner_first] == -1) {
		return true;
	}
	new
		dctx[DisasmContext],
		cur,
		Opcode:op,
		parseState = 4,
		parseParam;
	// Enable scans to start at a non-zero position.
	DisasmInit(dctx, csState[CodeScanMatch_cip] - gDat);
	for (cur = csState[CodeScanner_first]; cur != -1; CodeScanReset(CodeScanDeref(cur), cur)) { }
	while (CodeScanStepInternal(dctx, csState, parseState, parseParam)) {
		// Check the address - if it is a jump target that changes the stack
		// size BEFORE the instruction, while the instruction itself changes
		// it after.
		// Found a valid instruction that we don't want to ignore.  Finally
		// do the actual comparisons to various defined scanners.
		for (cur = csState[CodeScanner_first], op = DisasmGetOpcode(dctx); cur != -1; ) {
			if (CodeScanCheck(op, dctx, CodeScanDeref(cur), csState, cur)) {
				switch (CodeScanCall(CodeScanDeref(cur), csState)) {
					case cellmin: {
						// End right now.
						return true;
					}
					case -1: {
						// Want to skip this match.  However, it was a full
						// match so does need resetting.
						CodeScanReset(CodeScanDeref(cur), cur);
						continue;
					}
					case 0: {
						// Do nothing except ignore.
					}
					default: {
						// If code was written, reparse this function.
						dctx[DisasmContext_nip] = csState[CodeScanMatch_func];
					}
				}
				// Reset to the start of the function, to reparse.
				for (cur = csState[CodeScanner_first]; cur != -1; CodeScanReset(CodeScanDeref(cur), cur)) { }
				break;
			}
		}
	}
	return true;
}

stock CodeScanInit(scanner[CodeScanner]) {
	if (gFirstProc == 0) {
		new
			dctx[DisasmContext];
		DisasmInit(dctx);
		while (DisasmNextInsn(dctx) != OP_PROC) {}
		// This is the first time any code scanner has been set up.  Skip all
		// the initial state stubs and error traps.
		gFirstProc = DisasmGetCurIp(dctx),
		GetAmxHeader(gHdr),
		gBase = GetAmxBaseAddress() + gHdr[AMX_HDR_DAT],
		gDat = gHdr[AMX_HDR_COD] - gHdr[AMX_HDR_DAT],
		gOP_NOP = _:RelocateOpcode(OP_NOP);
		gOP_CASETBL = _:RelocateOpcode(OP_CASETBL);
	}
	CodeScanResetJumpTargets(scanner),
	scanner[CodeScanMatch_cip] = gFirstProc,
	scanner[CodeScanMatch_type] =
	 scanner[CodeScanMatch_name] =
	  scanner[CodeScanner_param] =
	   scanner[CodeScanner_state] =
	    scanner[CodeScanMatch_heap] =
	     scanner[CodeScanMatch_stack] = 0,
	scanner[CodeScanMatch_params] = cellmin,
	scanner[CodeScanner_first] = -1;
}

stock CodeScanClone(dest[CodeScanner], const src[CodeScanner]) {
	dest = src,
	dest[CodeScanner_first] = -1;
}

stock CodeScanGetFunctionScanner(const csm[CodeScanner], ret[CodeScanner], ctx[DisasmContext]) {
	// Doesn't do any decompilation, just gets the information for decompiling
	// the whole of the current function.
	CodeScanInit(ret),
	ctx[DisasmContext_end_ip] = 0,
	ctx[DisasmContext_start_ip] = ctx[DisasmContext_nip] = ctx[DisasmContext_cip] = csm[CodeScanMatch_func];
	switch (csm[CodeScanMatch_type]) {
		case 0, SCANNER_FUNC_AUTOMATA, SCANNER_FUNC_HALT, SCANNER_FUNC_AUTOMATA_NO_NAME, SCANNER_FUNC_HALT_NO_NAME: {
			ret[CodeScanner_state] = 4;
		}
		default: {
			ret[CodeScanner_state] = 0;
		}
	}
}

stock CodeScanGetMatchScanner(const csm[CodeScanner], ret[CodeScanner], ctx[DisasmContext], bool:accurate = false) {
	// Doesn't do any decompilation, just gets the information for decompiling
	// the currently found match.
	CodeScanGetFunctionScanner(csm, ret, ctx);
	if (accurate) {
		// To be accurate in terms of jump targets, we re-run the scanner over
		// the function back up to this point.
		while (ctx[DisasmContext_nip] < csm[CodeScanMatch_cip]) {
			CodeScanStepInternal(ctx, ret, ret[CodeScanner_state], ret[CodeScanner_param]);
		}
	} else {
		// For speed, we just change the current instruction pointers.
		ctx[DisasmContext_start_ip] = ctx[DisasmContext_nip] = ctx[DisasmContext_cip] = csm[CodeScanMatch_cip];
	}
}

stock CodeScanGetFunctionDisasm(const csm[CodeScanner], ctx[DisasmContext], offset = 0) {
	// Doesn't do any decompilation, just gets the information for decompiling
	// the whole of the current function.
	ctx[DisasmContext_end_ip] = 0,
	ctx[DisasmContext_start_ip] = ctx[DisasmContext_nip] = ctx[DisasmContext_cip] = csm[CodeScanMatch_func] + offset;
}

stock CodeScanGetMatchDisasm(const csm[CodeScanner], ctx[DisasmContext], offset = 0) {
	// Doesn't do any decompilation, just gets the information for decompiling
	// the currently found match.
	ctx[DisasmContext_end_ip] = 0,
	ctx[DisasmContext_start_ip] = ctx[DisasmContext_nip] = ctx[DisasmContext_cip] = csm[CodeScanMatch_cip] + offset;
}

stock CodeScanGetFunctionAsm(const csm[CodeScanner], ctx[AsmContext], offset = 0) {
	// Doesn't do any decompilation, just gets the information for writing to
	// the whole of the current function.
	AsmInitPtr(ctx, csm[CodeScanMatch_func] + offset, cellmax);
}

stock CodeScanGetMatchAsm(const csm[CodeScanner], ctx[AsmContext], offset = 0) {
	// Doesn't do any decompilation, just gets the information for writing to
	// the currently found match.
	AsmInitPtr(ctx, csm[CodeScanMatch_cip] + offset, cellmax);
}

stock CodeScanGetMatchFunc(const csm[CodeScanner]) {
	// The stored value is relative to "DAT", return relative to "COD".
	return csm[CodeScanMatch_func] - gDat;
}

stock CodeScanGetMatchAddress(const csm[CodeScanner]) {
	// The stored value is relative to "DAT", return relative to "COD".
	return csm[CodeScanMatch_cip] - gDat;
}

stock CodeScanGetMatchFuncData(const csm[CodeScanner]) {
	// Return relative to "DAT".
	return csm[CodeScanMatch_func];
}

stock CodeScanGetMatchAddressData(const csm[CodeScanner]) {
	// Return relative to "DAT".
	return csm[CodeScanMatch_cip];
}

stock CodeScanGetMatchLength(const csm[CodeScanner]) {
	return csm[CodeScanMatch_size];
}

stock CodeScanNOPMatch(const csm[CodeScanner]) {
	for (new dest = csm[CodeScanMatch_cip], end = dest + csm[CodeScanMatch_size]; dest != end; dest += cellbytes) {
		#emit LOAD.pri     gOP_NOP
		#emit SREF.S.pri   dest
	}
	{}
}

stock CodeScanGetMatchType(csm[CodeScanner]) {
	// Lazilly get the names and types of functions when requested.
	if (csm[CodeScanMatch_type] >= SCANNER_FUNC_UNKNOWN) {
		csm[CodeScanMatch_name][0] = '\0';
		if (CodeScanGetFuncName(csm[CodeScanMatch_func], csm[CodeScanMatch_name])) {
			csm[CodeScanMatch_type] -= 4;
		} else {
			csm[CodeScanMatch_type] /= 2;
			// We could check for functions that are state implementations.
			// Currently public functions with states will only get their names
			// for the state stub, not for the various implementations.
		}
	}
	// There are four types:
	//   
	//   PUBLIC   - Public functions.
	//   HALT     - The "halt" instructions at the very start.
	//   AUTOMATA - A state determining stub.
	//   OTHER    - A normal function.
	//   
	// These names are always prefixed by "SCANNER_FUNC_", and only "PUBLIC" is
	// guaranteed to have a name - the types are partially determined in other
	// ways ("OTHER" will never have a name).
	// 
	// There is also "0", which just means that nothing has been scanned yet.
	return csm[CodeScanMatch_type];
}

stock CodeScanGetMatchHeap(const csm[CodeScanner]) {
	return csm[CodeScanMatch_heap];
}

stock CodeScanGetMatchStack(const csm[CodeScanner]) {
	return csm[CodeScanMatch_stack];
}

stock CodeScanGetMatchHole(const csm[CodeScanner], idx) {
	return csm[CodeScanMatch_holes][idx];
}

stock CodeScanGetHoleCount(const csm[CodeScanner]) {
	return csm[CodeScanMatch_hole_count];
}

stock CodeScanGetMatchName(const csm[CodeScanner], name[]) {
	if (csm[CodeScanMatch_type] >= SCANNER_FUNC_UNKNOWN) {
		// We get the type, because the type is based on the name.
		CodeScanGetMatchType(csm);
	}
	name[0] = '\0',
	strcat(name, csm[CodeScanMatch_name], 32);
}

