# Colors
PINK_BRR     = \033[38;5;219m
YELLOW_BR   = \033[38;5;227m

# Text styles
BOLD        = \033[1m

NAME = libasm.a

NASM = nasm
NASMFLAGS = -f elf64
CC = gcc
CFLAGS = -Wall -Wextra -Werror
AR = ar rcs
RM = rm -f

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJS = $(SRCS:.s=.o)

BONUS_SRCS = ft_atoi_base.s ft_list_push_front.s ft_list_size.s ft_list_sort.s ft_list_remove_if.s
BONUS_OBJS = $(BONUS_SRCS:.s=.o)

EXEC = test
MAIN = main.c

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(NAME) $(OBJS)
	@echo "$(BOLD)$(PINK_BRR)\nlibasm is ready!$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢀⣾⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣰⣿⣿⣿⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣶⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⢼⡟⠉⣻⣿⣿⡏⠰⣷⠀⢹⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⢻⣷⡀⠙⣻⣿⣿⣄⣠⣴⡿⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⠀⣭⣉⣛⣻⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⢠⠞⢡⣽⣿⣿⠿⢻⣿⣿⣿⣏⣿⣿⣿⣧⣤⣤⣤⣄⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠘⣴⡨⠛⠋⠁⠀⣼⣿⣿⣿⡟⣿⣿⣿⣿⣯⢈⣿⣿⠂⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠘⠃⠀⠀⠀⢀⣤⣿⣷⡜⣿⣧⡉⠉⠙⠋⠁⠈⠉⠁⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(YELLOW_BR)⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⢠⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀$(DEF_COLOR)"
	@echo "$(BOLD)$(PINK_BRR)		   type make test$(DEF_COLOR)"

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	$(RM) $(OBJS) $(BONUS_OBJS)

fclean: clean
	$(RM) $(NAME) $(EXEC) obj.dump

re: fclean all

bonus: $(OBJS) $(BONUS_OBJS)
	$(AR) $(NAME) $(OBJS) $(BONUS_OBJS)

$(EXEC): $(NAME) $(MAIN)
	$(CC) $(CFLAGS) -fPIE $(MAIN) -L. -lasm -lc -o $(EXEC)

# $(EXEC): $(NAME) $(MAIN)
# 	$(CC) $(CFLAGS) $(MAIN) -L. -lasm -o $(EXEC)

dump: $(EXEC)
	objdump -S -M intel -d $(EXEC) > obj.dump
	cat obj.dump

.PHONY: all clean fclean re bonus dump
