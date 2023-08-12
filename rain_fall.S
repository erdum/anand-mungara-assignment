.section .text
.global _start

_start:
    push {r4, lr}
    
    ldr r0, =rainfall_prompt
    bl printf
    
    ldr r1, =rainfall_array
    ldr r2, =12

    @ Loop to input rainfall amounts
input_loop:
    ldr r0, =month_names
    bl printf
    
    ldr r0, =formatIn
    ldr r1, =input_buffer
    bl scanf

    @ Convert ASCII string to integer (int rainfall;)
    ldr r0, =input_buffer
    bl atoi

    str r0, [r3, r1, LSL #2]   @ Store the rainfall in the array

    subs r2, r2, #1
    bne input_loop

    ldr r1, =12
    ldr r2, =rainfall_array
    bl calculate_total_rainfall

    ldr r1, =12
    ldr r2, =rainfall_array
    bl calculate_average_rainfall

    ldr r1, =12
    ldr r2, =rainfall_array
    bl find_highest_rainfall

    ldr r1, =12
    ldr r2, =rainfall_array
    bl find_lowest_rainfall

    ldr r0, =output_message
    bl printf

    pop {r4, pc}

calculate_total_rainfall:
    push {lr}
    mov r3, #0

    @ Loop to calculate total rainfall
calc_total_loop:
    ldr r0, [r2, r1, LSL #2]
    add r3, r3, r0

    subs r1, r1, #1
    bne calc_total_loop

    mov r0, r3
    pop {pc}

calculate_average_rainfall:
    push {lr}
    mov r3, #0
    mov r4, #12

    @ Loop to calculate total rainfall
calc_avg_loop:
    ldr r0, [r2, r1, LSL #2]
    add r3, r3, r0

    subs r1, r1, #1
    bne calc_avg_loop

    mov r0, r3
    mov r1, r4
    bl multiply_divide

    pop {pc}

find_highest_rainfall:
    push {lr}
    ldr r0, [r2]
    mov r3, #0

    @ Loop to find highest rainfall
find_highest_loop:
    ldr r1, [r2, r3, LSL #2]
    cmp r1, r0
    movgt r0, r1

    adds r3, r3, #1
    cmp r3, r4
    bne find_highest_loop

    pop {pc}

find_lowest_rainfall:
    push {lr}
    ldr r0, [r2]
    mov r3, #0

    @ Loop to find lowest rainfall
find_lowest_loop:
    ldr r1, [r2, r3, LSL #2]
    cmp r1, r0
    movlt r0, r1

    adds r3, r3, #1
    cmp r3, r4
    bne find_lowest_loop

    pop {pc}

multiply_divide:
    push {lr}
    bl __aeabi_idivmod

    mov r0, r1
    pop {pc}

.section .data
rainfall_prompt:
    .asciz "Enter the total rainfall for each of the 12 months:\n"

month_names:
    .asciz "January: "
    .asciz "February: "
    .asciz "March: "
    .asciz "April: "
    .asciz "May: "
    .asciz "June: "
    .asciz "July: "
    .asciz "August: "
    .asciz "September: "
    .asciz "October: "
    .asciz "November: "
    .asciz "December: "

formatIn:
    .asciz "%d"

input_buffer:
    .space 20

rainfall_array:
    .int 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

output_message:
    .asciz "Total Rainfall: %d\nAverage Rainfall: %d\nHighest Rainfall: %"
