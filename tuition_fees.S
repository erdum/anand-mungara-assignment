.section .text
.global _start

_start:
    push {r4, lr}
    vpush {s0, s1}

    ldr r0, =tuition_fee   @ Load initial tuition fee ($10,000)
    mov r4, #0              @ Initialize loop counter

tuition_loop:
    cmp r4, #10             @ Compare loop counter with 10
    beq calculate_total    @ If equal, exit the loop

    @ Calculate new tuition fee (current_fee + current_fee * 0.04)
    ldr r1, [r0]            @ Load current tuition fee
    ldr r2, =float_0_04     @ Load the address of the constant 0.04
    vldr s0, [r2]           @ Load the constant 0.04 into s0
    bl multiply_float

    str r1, [r0]            @ Store new tuition fee

    adds r4, r4, #1         @ Increment loop counter
    b tuition_loop

calculate_total:
    ldr r0, =tuition_fee   @ Load initial tuition fee ($10,000)
    mov r4, #0              @ Reset loop counter
    mov r5, #0              @ Initialize total cost accumulator

four_year_total_loop:
    cmp r4, #4              @ Compare loop counter with 4
    beq done                @ If equal, exit the loop

    ldr r1, [r0]            @ Load current tuition fee
    adds r5, r5, r1         @ Add current tuition fee to total cost

    adds r4, r4, #1         @ Increment loop counter
    b four_year_total_loop

done:
    vpop {s0, s1}
    ldr r0, =output_message
    ldr r1, [r0]
    ldr r0, =tuition_fee
    ldr r2, [r0]
    bl printf

    pop {r4, pc}

multiply_float:
    vmul.f32 s1, s0, s1    @ Multiply s1 by s0 (0.04)
    vadd.f32 s1, s1, s2    @ Add the result to s2 (current_fee)
    bx lr

.section .data
tuition_fee:
    .float 10000.0          @ Initial tuition fee ($10,000)

float_0_04:
    .float 0.04             @ Constant 0.04

output_message:
    .asciz "Tuition fee after 10 years: $%.2f\nTotal cost of 4 years after 10th year: $%.2f\n"
