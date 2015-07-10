# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jelefebv <jelefebv@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/07/10 21:51:58 by jelefebv          #+#    #+#              #
#    Updated: 2015/07/10 21:51:58 by jelefebv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#NAME		=
#
#NAMEBASE    =   $(shell basename $(NAME))
#
#CC			=	gcc
#
#FLAGS		=	-Wall -Wextra -Werror
#
#SRCDIR		=	srcs/
#
#OBJDIR		=	objs/
#
#INCDIR		=	includes/
#
#LIBFT_DIR	=	libft/
#
#LIBFT_LIB	=	libft/libft.a
#
#SRCBASE		=	\
#
#INCBASE		=	\
#
#SRCS		=	$(addprefix $(SRCDIR), $(SRCBASE))
#
#INCS		=	$(addprefix $(INCDIR), $(INCBASE))
#
#OBJS		=	$(addprefix $(OBJDIR), $(SRCBASE:.c=.o))
#
#.SILENT:
#
#all:		$(NAME)
#	echo "\033[38;5;44m☑️  ALL    $(NAMEBASE) is done\033[0m\033[K"
#
#$(NAME):	$(OBJS)
#	$(CC) $(FLAGS) -o $(NAME) $(OBJS) $(LIBFT_LIB)
#	echo -en "\r\033[38;5;22m☑️  MAKE   $(NAMEBASE)\033[0m\033[K"
#	echo "\r\033[38;5;184m👥  GROUP MEMBER(S):\033[0m\033[K"
#	echo "\r\033[38;5;15m`cat auteur | sed s/^/\ \ \ \ -/g`\033[0m\033[K"
#
#$(OBJS):	$(SRCS) $(INCS)
#	printf "\r\033[38;5;11m⌛  MAKE   $(NAMEBASE) plz wait ...\033[0m\033[K"
#	mkdir -p $(OBJDIR)
#	make -C $(LIBFT_DIR)
#	(cd $(OBJDIR);															\
#	$(CC) $(FLAGS) -c $(addprefix ../, $(SRCS))								\
#	-I $(addprefix ../, $(LIBFT_DIR)/$(INCDIR))								\
#	-I $(addprefix ../, $(INCDIR)))
#
#clean:
#	printf "\r\033[38;5;11m⌛  CLEAN  $(NAMEBASE) plz wait ...\033[0m\033[K"
#	make -C $(LIBFT_DIR) clean
#	if [[ `rm -R $(OBJDIR) &> /dev/null 2>&1; echo $$?` == "0" ]]; then		\
#		echo -en "\r\033[38;5;124m🔘  CLEAN  $(NAMEBASE)\033[0m\033[K";		\
#	else																	\
#		printf "\r";														\
#	fi
#
#fclean:		clean
#	printf "\r\033[38;5;11m⌛  FCLEAN $(NAMEBASE) plz wait ...\033[0m\033[K"
#	make -C $(LIBFT_DIR) fclean
#	if [[ `rm $(NAME) &> /dev/null 2>&1; echo $$?` == "0" ]]; then			\
#		echo -en "\r\033[38;5;124m🔘  FCLEAN $(NAMEBASE)\033[0m\033[K";		\
#	else																	\
#		printf "\r";														\
#	fi
#
#re:			fclean all
#
#debug:		CC = cc
#debug:		FLAGS += --analyze
#debug:		re
#
#.PHONY:		fclean clean re

install:
	rm -rf "$(HOME)/#_my_config" $(HOME)/.vim $(HOME)/.vimrc
	mv ".vim" "$(HOME)/.vim"
	mv ".vimrc" "$(HOME)/.vimrc"
	mv "#_my_config" "$(HOME)/#_my_config"