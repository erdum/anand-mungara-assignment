#include <stdio.h>

const char *month_names[] = {
    "January", "February", "March", "April",
    "May", "June", "July", "August",
    "September", "October", "November", "December"
};

void calculate_total_rainfall(int *array) {
    int total = 0;
    for (int i = 0; i < 12; i++) {
        total += array[i];
    }
    printf("Total Rainfall: %d\n", total);
}

void calculate_average_rainfall(int *array) {
    int total = 0;
    for (int i = 0; i < 12; i++) {
        total += array[i];
    }
    int average = total / 12;
    printf("Average Rainfall: %d\n", average);
}

int find_highest_rainfall(int *array) {
    int highest = array[0];
    for (int i = 1; i < 12; i++) {
        if (array[i] > highest) {
            highest = array[i];
        }
    }
    return highest;
}

int find_lowest_rainfall(int *array) {
    int lowest = array[0];
    for (int i = 1; i < 12; i++) {
        if (array[i] < lowest) {
            lowest = array[i];
        }
    }
    return lowest;
}

int main() {
    int rainfall_array[12];
    printf("Enter the total rainfall for each of the 12 months:\n");

    for (int i = 0; i < 12; i++) {
        printf("%s: ", month_names[i]);
        scanf("%d", &rainfall_array[i]);
    }

    calculate_total_rainfall(rainfall_array);
    calculate_average_rainfall(rainfall_array);

    int highest = find_highest_rainfall(rainfall_array);
    printf("Highest Rainfall: %d\n", highest);

    int lowest = find_lowest_rainfall(rainfall_array);
    printf("Lowest Rainfall: %d\n", lowest);

    return 0;
}
