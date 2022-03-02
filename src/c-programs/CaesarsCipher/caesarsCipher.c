#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

enum {MAX_LEN = 1024};

int main(void) {
    size_t len;
    int shift;
    int key=13;
    char *text;
    char num[16];

    text = malloc(MAX_LEN);
    if (text == NULL) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }

    printf("Input text to be encrypted (lowercase): ");
    fflush(stdout);
    if (fgets(text, MAX_LEN, stdin) == NULL)
        exit(EXIT_FAILURE);

    len = strlen(text);
    if (text[len - 1] == '\n')
        text[len - 1] = '\0';
    len -= 1;

    printf("Choose shift number [1-26]: ");
    fflush(stdout);
    if (fgets(num, 16, stdin) == NULL)
        exit(EXIT_FAILURE);

    shift = (int) strtol(num, NULL, 0);
    if (shift < 1 || shift > 26) {
        fprintf(stderr, "Shift number is out of range");
        exit(EXIT_FAILURE);
    }

    for (int i = 0; i < len; ++i) {
        if (!isspace(text[i]) || !isblank(text[i]))
            printf("%c", (((text[i] - 97)+shift)%26)+97);
        else
            printf("%c", text[i]);
    }

    exit(EXIT_SUCCESS);
}
