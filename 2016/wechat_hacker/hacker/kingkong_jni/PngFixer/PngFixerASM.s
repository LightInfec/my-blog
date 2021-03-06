.text
.align 2
.global FIXER_ENTRY_CODE32
.type FIXER_ENTRY_CODE32, %common
.global FIXER_PARAMETERS_START
.type FIXER_PARAMETERS_START, %common
.global FIXER_PARAMETERS_END
.type FIXER_PARAMETERS_END, %common

.global PATCH_DRIVER_FUNCTION_START
.type PATCH_DRIVER_FUNCTION_START, %common
.global PATCH_DRIVER_FUNCTION_reportEvilCatched
.type PATCH_DRIVER_FUNCTION_reportEvilCatched, %common
.global PATCH_DRIVER_FUNCTION_reportCxaFinalizeCalled
.type PATCH_DRIVER_FUNCTION_reportCxaFinalizeCalled, %common
.global PATCH_DRIVER_FUNCTION_reportFixerErrorOccurred
.type PATCH_DRIVER_FUNCTION_reportFixerErrorOccurred, %common
.global PATCH_DRIVER_FUNCTION_cxa_finalize
.type PATCH_DRIVER_FUNCTION_cxa_finalize, %common
.global PATCH_DRIVER_FUNCTION_original_LR
.type PATCH_DRIVER_FUNCTION_original_LR, %common
.global PATCH_DRIVER_FUNCTION_END
.type PATCH_DRIVER_FUNCTION_END, %common


.code 32
FIXER_ENTRY_CODE32:
PNG_FIXER_ENTRY_CODE32:
		LDRB	R1, [R0, #1]
		LDRB	R2, [R0, #2]
		LDRB	R3, [R0, #3]
		ADD		R2, R1, R2
		ADD		R2, #8
		ADD		R0, R2, R3
		LSL		R0, R0, #2

		LDR		R1, PNG_REGISTER
		CMP		R1, #4
		BEQ 	FROM_REG4
		CMP		R1, #5
		BEQ 	FROM_REG5
		CMP		R1, #6
		BEQ 	FROM_REG6
		CMP		R1, #7
		BEQ 	FROM_REG7
		CMP		R1, #8
		BEQ 	FROM_REG8
		CMP		R1, #9
		BEQ 	FROM_REG9
		CMP		R1, #10
		BEQ 	FROM_REG10
		CMP		R1, #11
		BEQ 	FROM_REG11
		CMP		R1, #12
		BEQ 	FROM_REG12
		B		FALSE_EXIT

FROM_REG4:
		CMP		R0, R4
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG5:
		CMP		R0, R5
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG6:
		CMP		R0, R6
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG7:
		CMP		R0, R7
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG8:
		CMP		R0, R8
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG9:
		CMP		R0, R9
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG10:
		CMP		R0, R10
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG11:
		CMP		R0, R11
		BNE		FALSE_EXIT
		B		TRUE_EXIT
FROM_REG12:
		CMP		R0, R12
		BNE		FALSE_EXIT
		B		TRUE_EXIT

TRUE_EXIT:
		LDR		LR, TRUE_EXIT_ADDR_16
		NOP
		NOP
		BX 		LR

FALSE_EXIT:

		LDR		R0, PATCH_DRIVER_FUNCTION_reportEvilCatched
		BLX		R0

		MOVS	R0, #0
		LDR		LR, FALSE_EXIT_ADDR_16
		NOP
		NOP
		BX		LR

FIXER_PARAMETERS_START:
PARAM_HOOK_POINT:
.word	0	@ unused here
TRUE_EXIT_ADDR_16:
.word	TRUE_EXIT_ADDR_16
FALSE_EXIT_ADDR_16:
.word	FALSE_EXIT_ADDR_16
PNG_REGISTER:
.word	PNG_REGISTER
FIXER_PARAMETERS_END:
.word	FIXER_PARAMETERS_END

PATCH_DRIVER_FUNCTION_START:
PATCH_DRIVER_FUNCTION_reportEvilCatched:
.word	PATCH_DRIVER_FUNCTION_reportEvilCatched
PATCH_DRIVER_FUNCTION_reportCxaFinalizeCalled:
.word	PATCH_DRIVER_FUNCTION_reportCxaFinalizeCalled
PATCH_DRIVER_FUNCTION_reportFixerErrorOccurred:
.word	PATCH_DRIVER_FUNCTION_reportFixerErrorOccurred
PATCH_DRIVER_FUNCTION_cxa_finalize:
.word	PATCH_DRIVER_FUNCTION_cxa_finalize
PATCH_DRIVER_FUNCTION_original_LR:
.word	PATCH_DRIVER_FUNCTION_original_LR
PATCH_DRIVER_FUNCTION_END:
.word	PATCH_DRIVER_FUNCTION_END

