#include <stdio.h>

float tuition_fee = 10000.0; // Initial tuition fee ($10,000)

void multiply_float(float *result, float factor) {
    *result = *result * factor;
}

int main() {
    float constant_0_04 = 0.04;
    int loop_counter = 0;

    for (loop_counter = 0; loop_counter < 10; loop_counter++) {
        // Calculate new tuition fee (current_fee + current_fee * 0.04)
        tuition_fee = tuition_fee + tuition_fee * constant_0_04;
    }

    float total_cost = 0;
    for (loop_counter = 0; loop_counter < 4; loop_counter++) {
        total_cost += tuition_fee;
    }

    printf("Tuition fee after 10 years: $%.2f\nTotal cost of 4 years after 10th year: $%.2f\n", tuition_fee, total_cost);

    return 0;
}
