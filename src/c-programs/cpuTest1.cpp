#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define MILLION * 1000000

static void commaOut (int n, char c) {
    if (n < 1000) {
        printf ("%d%c", n, c);
        return;
    }

    commaOut (n / 1000, ',');
    printf ("%03d%c", n % 1000, c);
}

int main (int argc, char *argv[]) {
    int i;

    system("date");
    clock_t start = clock();
    clock_t end = start;

    while (end - start < 30 MILLION) {
        for (i = 10 MILLION; i > 0; i--) {};
        end = clock();
    }

    system("date");
    commaOut (end - start, '\n');

    return 0;
}
