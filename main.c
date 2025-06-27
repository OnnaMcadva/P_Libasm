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

typedef struct s_list {
    void *data;
    struct s_list *next;
} t_list;

extern int ft_atoi_base(const char *str, const char *base);
extern void ft_list_push_front(t_list **begin_list, void *data);
extern int ft_list_size(t_list *begin_list);
extern void ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *));
extern void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *));

int cmp_str(void *a, void *b) {
    return strcmp((char *)a, (char *)b);
}

void free_str(void *p) {
    free(p);
}

void print_list(t_list *lst) {
    while (lst) {
        printf("-> \"%s\" ", (char *)lst->data);
        lst = lst->next;
    }
    printf("-> NULL\n");
}

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
    fflush(stdout); // ← это решает проблему???
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

    
      // BONUS
        // ft_atoi_base
    printf("\n--- ft_atoi_base ---\n");
    printf("ft_atoi_base(\"1010\", \"01\") = %d (should be 10)\n", ft_atoi_base("1010", "01"));
    printf("ft_atoi_base(\"-1A\", \"0123456789ABCDEF\") = %d (should be -26)\n", ft_atoi_base("-1A", "0123456789ABCDEF"));
    printf("ft_atoi_base(\"zz\", \"z\") = %d (should be 0 — invalid base)\n", ft_atoi_base("zz", "z"));

    t_list *list = NULL;
    // ft_list_push_front and ft_list_size
    printf("\n--- ft_list_push_front / ft_list_size ---\n");
    ft_list_push_front(&list, strdup("third"));
    ft_list_push_front(&list, strdup("second"));
    ft_list_push_front(&list, strdup("first"));
    printf("List size: %d\n", ft_list_size(list));
    print_list(list);

    // ft_list_sort
    printf("\n---Sort test:---\n");
    t_list *sort_list = NULL;
    char *test_data[] = {"date", "cherry", "banana", "apple", NULL};
    for (int i = 0; test_data[i] != NULL; i++) {
        char *dup = strdup(test_data[i]);
        if (!dup) {
            printf("Memory allocation failed!\n");
            exit(1);
        }
        ft_list_push_front(&sort_list, dup);
    }
    
    printf("Before sort: ");
    print_list(sort_list);
    
    ft_list_sort(&sort_list, cmp_str);
    
    printf("After sort: ");
    print_list(sort_list);
    
    while (sort_list) {
        t_list *tmp = sort_list->next;
        free(sort_list->data);
        free(sort_list);
        sort_list = tmp;
    }

    printf("\n---Remove if test:---\n");
    printf("Original list: ");
    print_list(list);
    
    ft_list_remove_if(&list, "second", cmp_str, free_str);
    printf("After removing 'second': ");
    print_list(list);
    
    while (list) {
        t_list *tmp = list->next;
        free(list->data);
        free(list);
        list = tmp;
    }
    return 0;
}


// gcc -Wall -Wextra -Werror main.c -L. -lasm -o test_exec
// make           # соберёт libasm.a
// make test # соберёт main.c и слинкует с библиотекой
// make dump      # выведет дизассемблированный код исполняемого файла
