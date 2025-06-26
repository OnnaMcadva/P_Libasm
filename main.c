#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>

extern size_t ft_strlen(const char *s);
extern char *ft_strcpy(char *dst, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern ssize_t ft_write(int fd, const void *buf, size_t count);
extern ssize_t ft_read(int fd, void *buf, size_t count);
extern char *ft_strdup(const char *s);

int main(void) {
    char str[] = "Hello, World!";
    char dst[50];
    char *dup;
    char buf[50];
    ssize_t ret;

    // Тест ft_strlen
    printf("ft_strlen(\"%s\") = %zu\n", str, ft_strlen(str));

    // Тест ft_strcpy
    ft_strcpy(dst, str);
    printf("ft_strcpy(dst, \"%s\") = \"%s\"\n", str, dst);

    // Тест ft_strcmp
    printf("ft_strcmp(\"%s\", \"%s\") = %d\n", str, "Hello", ft_strcmp(str, "Hello"));
    printf("ft_strcmp(\"%s\", \"%s\") = %d\n", str, str, ft_strcmp(str, str));

    // Тест ft_write
    ret = ft_write(1, str, ft_strlen(str));
    printf("\nft_write: %zd bytes written\n", ret);
    ret = ft_write(-1, str, ft_strlen(str));
    printf("ft_write (invalid fd): %zd, errno = %d\n", ret, errno);

    // Тест ft_read
    printf("Enter some text: ");
    ret = ft_read(0, buf, 49);
    if (ret >= 0) {
        buf[ret] = '\0';
        printf("ft_read: %zd bytes read, content: %s\n", ret, buf);
    } else {
        printf("ft_read error: %zd, errno = %d\n", ret, errno);
    }

    // Тест ft_strdup
    dup = ft_strdup(str);
    if (dup) {
        printf("ft_strdup(\"%s\") = \"%s\"\n", str, dup);
        free(dup);
    } else {
        printf("ft_strdup failed, errno = %d\n", errno);
    }

      // --- Boundary tests ---

    // Empty string tests
    printf("\n--- Boundary tests ---\n");

    // ft_strlen with empty string
    printf("ft_strlen(\"\") = %zu\n", ft_strlen(""));

    // ft_strcpy with empty string
    ft_strcpy(dst, "");
    printf("ft_strcpy(dst, \"\") = \"%s\"\n", dst);

    // ft_strcmp with empty strings
    printf("ft_strcmp(\"\", \"\") = %d\n", ft_strcmp("", ""));
    printf("ft_strcmp(\"\", \"nonempty\") = %d\n", ft_strcmp("", "nonempty"));
    printf("ft_strcmp(\"nonempty\", \"\") = %d\n", ft_strcmp("nonempty", ""));

    // ft_write with zero bytes to write
    ret = ft_write(1, str, 0);
    printf("ft_write with 0 bytes: %zd\n", ret);

    // ft_read with zero bytes to read
    ret = ft_read(0, buf, 0);
    printf("ft_read with 0 bytes: %zd\n", ret);

    // ft_strdup with empty string
    dup = ft_strdup("");
    if (dup) {
        printf("ft_strdup(\"\") = \"%s\"\n", dup);
        free(dup);
    } else {
        printf("ft_strdup(\"\") failed, errno = %d\n", errno);
    }

    // Large string for ft_strlen and ft_strdup
    char large_str[1001];
    for (int i = 0; i < 1000; i++)
        large_str[i] = 'a';
    large_str[1000] = '\0';

    printf("ft_strlen(large_str of length 1000) = %zu\n", ft_strlen(large_str));

    dup = ft_strdup(large_str);
    if (dup) {
        printf("ft_strdup(large_str) succeeded, length = %zu\n", ft_strlen(dup));
        free(dup);
    } else {
        printf("ft_strdup(large_str) failed, errno = %d\n", errno);
    }

    return 0;
}


// gcc -Wall -Wextra -Werror main.c -L. -lasm -o test_exec
// make           # соберёт libasm.a
// make test_exec # соберёт main.c и слинкует с библиотекой
// make dump      # выведет дизассемблированный код исполняемого файла
