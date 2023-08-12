.section .data
weight:
    .float 0.0


.section .text
.global _start

_start:
    push {r4, lr}
    sub sp, sp, #20

    ldr r0, =prompt
    bl printf

    ldr r0, =formatIn
    ldr r1, =buffer
    bl scanf

    ldr r0, =buffer
    bl atof

    ldr r1, =weight
    ldr r1, [r1]
    vldr s0, [r1]
    vcmp.f32 s0, #0.0
    vmrs APSR_nzcv, fpscr

    bmi invalid_weight

    ldr r0, =low_threshold
    vcmp.f32 s0, s0
    vmrs APSR_nzcv, fpscr
    bmi low_cost

    ldr r0, =medium_threshold
    vcmp.f32 s0, s0
    vmrs APSR_nzcv, fpscr
    bmi medium_cost

    ldr r0, =high_threshold
    vcmp.f32 s0, s0
    vmrs APSR_nzcv, fpscr
    bmi high_cost

    ldr r0, =very_high_threshold
    vcmp.f32 s0, s0
    vmrs APSR_nzcv, fpscr
    bmi very_high_cost

    b cannot_ship

invalid_weight:
    ldr r0, =message_invalid
    bl printf
    b done

low_cost:
    ldr r0, =message_low_cost
    bl printf
    b done

medium_cost:
    ldr r0, =message_medium_cost
    bl printf
    b done

high_cost:
    ldr r0, =message_high_cost
    bl printf
    b done

very_high_cost:
    ldr r0, =message_very_high_cost
    bl printf
    b done

cannot_ship:
    ldr r0, =message_cannot_ship
    bl printf

done:
    add sp, sp, #20
    pop {r4, pc}

.section .data
prompt:
    .asciz "Enter the weight of the package (in pounds): "

formatIn:
    .asciz "%f"

buffer:
    .space 20

low_threshold:
    .float 1.0

medium_threshold:
    .float 3.0

high_threshold:
    .float 10.0

very_high_threshold:
    .float 20.0

message_invalid:
    .asciz "Invalid weight.\n"

message_low_cost:
    .asciz "Shipping cost: $3.5\n"

message_medium_cost:
    .asciz "Shipping cost: $5.5\n"

message_high_cost:
    .asciz "Shipping cost: $8.5\n"

message_very_high_cost:
    .asciz "Shipping cost: $10.5\n"

message_cannot_ship:
    .asciz "The package cannot be shipped.\n"
