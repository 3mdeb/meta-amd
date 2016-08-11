/*****************************************************************************
*
* Copyright (c) 2014, Advanced Micro Devices, Inc.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Advanced Micro Devices, Inc. nor the names of
*       its contributors may be used to endorse or promote products derived
*       from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL ADVANCED MICRO DEVICES, INC. BE LIABLE FOR ANY
* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
***************************************************************************/
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <errno.h>
#include <string.h>

#include <readline/readline.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/ioctl.h>

#include "gpio-test.h"

#define GPIO_APP_VERSION	"0.1"
#define AMD_GPIO_NUM_PINS	184
static int gpio_in_use[AMD_GPIO_NUM_PINS];

char *show_prompt(void)
{
	return "$ ";
}

void sighandler(int sig)
{
	printf("\n%s", show_prompt());
}

void show_license(void)
{
	printf("/*****************************************************************************\n"
	       "*\n"
	       "* Copyright (c) 2014, Advanced Micro Devices, Inc.\n"
	       "* All rights reserved.\n"
	       "*\n"
	       "* Redistribution and use in source and binary forms, with or without\n" 
	       "* modification, are permitted provided that the following conditions are met:\n"
	       "*     * Redistributions of source code must retain the above copyright\n"
	       "*       notice, this list of conditions and the following disclaimer.\n"
	       "*     * Redistributions in binary form must reproduce the above copyright\n"
	       "*       notice, this list of conditions and the following disclaimer in the\n"
	       "*       documentation and/or other materials provided with the distribution.\n"
	       "*     * Neither the name of Advanced Micro Devices, Inc. nor the names of\n"
	       "*       its contributors may be used to endorse or promote products derived\n"
	       "*       from this software without specific prior written permission.\n"
	       "*\n"
	       "* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND\n"
	       "* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\n"
	       "* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\n"
	       "* DISCLAIMED. IN NO EVENT SHALL ADVANCED MICRO DEVICES, INC. BE LIABLE FOR ANY\n"
	       "* DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n"
	       "* (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\n"
	       "* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\n"
	       "* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n"
	       "* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\n"
	       "* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n"
	       "*\n"
	       "*\n"
	       "***************************************************************************/\n");
}

void print_usage()
{
	printf("\nCommands Supported ->\n");
	printf(" getgpiomode <gpio>			: Gets the mode of GPIO pin\n");
	printf(" setgpiomode <gpio> <in/out/high/low>	: Sets the mode of GPIO pin to input or output(high/low)\n");
	printf(" getgpiovalue <gpio>			: Gets the value of GPIO pin\n");
	printf(" setgpiovalue <gpio> <high/low>		: Sets the value of GPO pin to high or low\n");
	printf(" getnumgpio				: Gets the number of GPIO pins supported\n");
	printf(" getgpiobase				: Gets the number of first GPIO pin\n");
	printf(" getgpioname				: Gets the name of GPIO driver currently in use\n");
	printf(" dmesg					: Displays the kernel log messages related to GPIO\n");
	printf(" license				: Displays the terms of LICENSE for this application\n");
	printf(" help					: Displays help text\n");
	printf(" exit					: Exits the application\n\n");
}

void parse_cmd(const char *cmdline)
{
	int fd;

	if ((cmdline == NULL) || (strncmp(cmdline, "exit", 4) == 0)) {
		int i;
		int ret;
		char gpio[3 + 1];

		printf("\nExiting...\n");

		/* We need to unexport all the GPIO pins exported earlier */
		for (i = 0; i < AMD_GPIO_NUM_PINS; i++) {
			if (gpio_in_use[i]) {
				int fd;

				fd = open("/sys/class/gpio/unexport", O_WRONLY);
				if (fd < 0) {
					printf("\nPlease make sure AMD GPIO driver is loaded\n");
					exit(EXIT_FAILURE);
				}
				memset(gpio, '\0', (3 + 1));
				snprintf(gpio, 4, "%d", i);

				ret = write(fd, gpio, strlen(gpio));
				if (ret < 0)
					perror("Error writing to /sys/class/gpio/unexport");
			}
		}

		exit(EXIT_SUCCESS);
	} else if (strncmp(cmdline, "help", 4) == 0)
		print_usage();
	else if (strncmp(cmdline, "getnumgpio", 10) == 0) {
		int fd;
		char ngpio[3 + 1];

		memset(ngpio, '\0', (3 + 1));
		fd = open("/sys/class/gpio/gpiochip0/ngpio", O_RDONLY);
		if (fd < 0) {
			printf("\nPlease make sure AMD GPIO driver is loaded\n");
			exit(EXIT_FAILURE);
		}

		/* Value read from the file is ASCII text */
		if(read(fd, ngpio, 3) < 0)
			perror("Cannot read number of GPIO pins");

		printf("\nThe maximum number of GPIO pins supported is %d\n", atoi(ngpio));
		close(fd);
	} else if (strncmp(cmdline, "getgpiobase", 11) == 0) {
		int fd;
		char gpiobase[3 + 1];

		memset(gpiobase, '\0', (3 + 1));
		fd = open("/sys/class/gpio/gpiochip0/base", O_RDONLY);
		if (fd < 0) {
			printf("\nPlease make sure AMD GPIO driver is loaded\n");
			exit(EXIT_FAILURE);
		}

		if(read(fd, gpiobase, 3) < 0)
			perror("Cannot read GPIO base");

		printf("\nGPIO pin numbering starts from %d\n", atoi(gpiobase));
		close(fd);
	} else if (strncmp(cmdline, "getgpioname", 11) == 0) {
		int fd;
		char gpioname[10 + 1]; /* Max 10 characters + NULL character */

		/* Zero initialize gpioname array */
		memset(gpioname, '\0', sizeof(gpioname));

		fd = open("/sys/class/gpio/gpiochip0/label", O_RDONLY);
		if (fd < 0) {
			printf("\nPlease make sure AMD GPIO driver is loaded\n");
			exit(EXIT_FAILURE);
		}

		if(read(fd, gpioname, 10) < 0)
			perror("Cannot read GPIO driver name");

		printf("\nGPIO driver loaded is %s\n", gpioname);
		close(fd);
	} else if (strncmp(cmdline, "getgpiovalue", 12) == 0) {
		int fd;
		int gpio;
		const char *charp = cmdline;
		char pathname[80];
		int ret = 0;

		/* Lets point to the end of first token */
		charp += strlen("getgpiovalue");
		/* Skip blank characters */
		while (*charp == ' ' || *charp == '\t' || *charp == '\n')
			charp++;

		/* Now we should be pointing to the first 'digit' character */
		gpio = atoi(charp);

		fd = open("/sys/class/gpio/export", O_WRONLY);
		if (fd < 0) {
			if (errno == EACCES)
				printf("\nYou do not have correct permission, please run as root\n");
			else
				perror("Eror opening /sys/class/gpio/export");

			exit(EXIT_FAILURE);
		}

		ret = write(fd, charp, strlen(charp));
		/*
		 * There can be two situations ->
		 *      1) The GPIO is being exported for the first time.
		 *      2) The GPIO is being exported again.
		 * In the first case, the write to file descriptor should
		 * succeed, and we should still fall into the if clause.
		 *
		 * In the second case, write will fail and errno will be
		 * set to EBUSY, since the GPIO pin is already exported.
		 * Rest all is error.
		 */
		if((ret >= 0) || ((ret < 0) && (errno == EBUSY))) {
			/* Close the last file descriptor */
			close(fd);

			memset(pathname, '\0', sizeof(pathname));
			sprintf(pathname, "/sys/class/gpio/gpio%d/value", gpio);

			fd = open(pathname, O_RDONLY);
			if (fd < 0)
				perror("GPIO read error");
			else {
				char value[1 + 1];

				memset(value, '\0', 2);
				ret = read(fd, value, 1);
				if (ret < 0)
					perror("Cannot read GPIO pin");

				printf("\nGPIO pin %s is at \"%s\"\n", charp,
				(strncmp(value, "1", 1) == 0) ? "high" : "low");

				close(fd);

				/*
				 * Mark the GPIO as already exported, so that we can use
				 * unexport them during exit.
				 */
				gpio_in_use[gpio] = 1;
			}
		} else {
			if (errno == EINVAL)
				printf("\nInvalid GPIO number\n");
			else
				perror("Error exporting GPIO number");

			close(fd);
		}
	} else if (strncmp(cmdline, "getgpiomode", 11) == 0) {
		int fd;
		int gpio;
		const char *charp = cmdline;
		char pathname[80];
		int ret = 0;

		/* Lets point to the end of first token */
		charp += strlen("getgpiomode");
		/* Skip blank characters */
		while (*charp == ' ' || *charp == '\t' || *charp == '\n')
			charp++;

		/* Now we should be pointing to the first 'digit' character */
		gpio = atoi(charp);

		fd = open("/sys/class/gpio/export", O_WRONLY);
		if (fd < 0) {
			if (errno == EACCES)
				printf("\nYou do not have correct permission, please run as root\n");
			else
				perror("Eror opening /sys/class/gpio/export");

			exit(EXIT_FAILURE);
		}

		ret = write(fd, charp, strlen(charp));
		/*
		 * There can be two situations ->
		 *      1) The GPIO is being exported for the first time.
		 *      2) The GPIO is being exported again.
		 * In the first case, the write to file descriptor should
		 * succeed, and we should still fall into the if clause.
		 *
		 * In the second case, write will fail and errno will be
		 * set to EBUSY, since the GPIO pin is already exported.
		 * Rest all is error.
		 */
		if((ret >= 0) || ((ret < 0) && (errno == EBUSY))) {
			FILE *fp;

			/* Close the last file descriptor */
			close(fd);

			memset(pathname, '\0', sizeof(pathname));
			sprintf(pathname, "/sys/class/gpio/gpio%d/direction", gpio);

			fp = fopen(pathname, "r");
			if (fp == NULL)
				perror("GPIO read error");
			else {
				char mode[3 + 1];
				int c, i = 0;

				memset(mode, '\0', (3 + 1));
				/*
				 * Since we do not exactly know whether the
				 * direction will be 'in' or 'out', we need to
				 * use fgetc() so that we read the input till
				 * we find terminating '\n', at which point
				 * we stop reading any further.
				 */
				while ((c = fgetc(fp)) != '\n')
					mode[i++] = c;

				printf("\nGPIO pin %s is in \"%s\" mode\n", charp,
				(strncmp(mode, "in", 2) == 0) ? "input" : "output");

				fclose(fp);

				/*
				 * Mark the GPIO as already exported, so that we can use
				 * unexport them during exit.
				 */
				gpio_in_use[gpio] = 1;
			}
		} else {
			if (errno == EINVAL)
				printf("\nInvalid GPIO number\n");
			else
				perror("Error exporting GPIO number");

			close(fd);
		}
	} else if (strncmp(cmdline, "setgpiomode", 11) == 0) {
		int fd;
		const char *charp = cmdline;
		int i = 0;
		char gpio[3 + 1];
		int ngpio;
		int ret;

		charp += strlen("setgpiomode");
		while (*charp == ' ' || *charp == '\t' || *charp == '\n')
			charp++;

		memset(gpio, '\0', (3 + 1));
		/*
		 * We are at the start of string which contains the GPIO
		 * number. We look for the end of this string, copying
		 * byte by byte into array. We also make sure that we
		 * do not store more than 3 bytes into the array, since
		 * a GPIO can have a maximum value of 183, that is, not
		 * exceeding 3 characters.
		 */
		while (*charp != ' ' && *charp != '\t' && (i < 3)) {
			gpio[i++] = *charp;
			charp++;
		}

		ngpio = atoi(gpio);

		fd = open("/sys/class/gpio/export", O_WRONLY);
		if (fd < 0) {
			if (errno == EACCES)
				printf("\nYou do not have correct permission, please run as root\n");
			else
				perror("Eror opening /sys/class/gpio/export");

			exit(EXIT_FAILURE);
		}

		ret = write(fd, gpio, strlen(gpio));
		if((ret >= 0) || ((ret < 0) && (errno == EBUSY))) {
			char pathname[80];

			/* Close the last file descriptor */
			close(fd);

			memset(pathname, '\0', sizeof(pathname));
			sprintf(pathname, "/sys/class/gpio/gpio%d/direction", ngpio);

			fd = open(pathname, O_WRONLY);
			if (fd < 0)
				perror("GPIO read error");
			else {
				char mode[4 + 1];

				memset(mode, '\0', (4 + 1));

				/* Lets skip the blanks till we find a character */
				while (*charp == ' ' || *charp == '\t')
					charp++;

				i = 0;
				/*
				 * Mode can be 'in', 'out', 'high' or 'low',
				 * again a maximum of 4 characters.
				 */
				while (*charp != ' ' && *charp != '\t' && (i < 4)) {
					mode[i++] = *charp;
					charp++;
				}

				/* Sanity check */
				if ((strncmp(mode, "in", 2) == 0) ||
				    (strncmp(mode, "out", 3) == 0) ||
				    (strncmp(mode, "high", 4) == 0) ||
				    (strncmp(mode, "low", 3) == 0)) {
					/* Write mode into /sys/.../direction file */
					ret = write(fd, mode, strlen(mode));
					if (ret < 0)
						perror("Error writing GPIO mode");
				} else
					printf("\nInvalid GPIO mode, please try again\n");

				close(fd);

				/*
				 * Mark the GPIO as exported, so that we can use
				 * unexport them during exit.
				 */
				gpio_in_use[ngpio] = 1;
			}
		} else {
			if (errno == EINVAL)
				printf("\nInvalid GPIO number\n");
			else
				perror("Error exporting GPIO number");

			close(fd);
		}
	} else if (strncmp(cmdline, "setgpiovalue", 12) == 0) {
		int fd;
		const char *charp = cmdline;
		int i = 0;
		char gpio[3 + 1];
		int ngpio;
		int ret;

		charp += strlen("setgpiovalue");
		while (*charp == ' ' || *charp == '\t' || *charp == '\n')
			charp++;

		memset(gpio, '\0', (3 + 1));
		/*
		 * We are at the start of string which contains the GPIO
		 * number. We look for the end of this string, copying
		 * byte by byte into array. We also make sure that we
		 * do not store more than 3 bytes into the array, since
		 * a GPIO can have a maximum value of 183, that is, not
		 * exceeding 3 characters.
		 */
		while (*charp != ' ' && *charp != '\t' && (i < 3)) {
			gpio[i++] = *charp;
			charp++;
		}

		ngpio = atoi(gpio);

		fd = open("/sys/class/gpio/export", O_WRONLY);
		if (fd < 0) {
			if (errno == EACCES)
				printf("\nYou do not have correct permission, please run as root\n");
			else
				perror("Eror opening /sys/class/gpio/export");

			exit(EXIT_FAILURE);
		}

		ret = write(fd, gpio, strlen(gpio));
		if((ret >= 0) || ((ret < 0) && (errno == EBUSY))) {
			char pathname[80];

			/* Close the last file descriptor */
			close(fd);

			memset(pathname, '\0', sizeof(pathname));
			sprintf(pathname, "/sys/class/gpio/gpio%d/value", ngpio);

			fd = open(pathname, O_WRONLY);
			if (fd < 0)
				perror("GPIO read error");
			else {
				char value[1 + 1];

				memset(value, '\0', (1 + 1));

				/* Lets skip the blanks till we find a character */
				while (*charp == ' ' || *charp == '\t')
					charp++;

				i = 0;

				if (strncmp(charp, "high", 4) == 0)
					value[0] = '1';
				else if (strncmp(charp, "low", 3) == 0)
					value[0] = '0';
				else {
					printf("\nInvalid input, please try again...\n");
					goto out;
				}

				/* Write mode into /sys/.../direction file */
				ret = write(fd, value, 1);
				if (ret < 0)
					perror("Error writing GPIO mode");

out:
				close(fd);

				/*
				 * Mark the GPIO as exported, so that we can use
				 * unexport them during exit.
				 */
				gpio_in_use[ngpio] = 1;
			}
		} else {
			if (errno == EINVAL)
				printf("\nInvalid GPIO number\n");
			else
				perror("Error exporting GPIO number");

			close(fd);
		}
	} else if (strncmp(cmdline, "dmesg", 5) == 0) {
		if (system("dmesg | grep GPIO") < 0)
			perror("Error executing \'dmesg | grep GPIO\'");
	} else if (strncmp(cmdline, "license", 7) == 0) {
		show_license();
	} else {
		printf("\nUnknown command\n");
		print_usage();
	}
}

int main(void)
{
	char *cmdline= NULL;

	printf("GPIO sample application version: %s\n", GPIO_APP_VERSION);
	printf("Copyright (c) 2014, Advanced Micro Devices, Inc.\n"
	       "This sample application comes with ABSOLUTELY NO WARRANTY;\n"
	       "This is free software, and you are welcome to redistribute it\n"
	       "under certain conditions; type `license' for details.\n\n");

	/* Handler for Ctrl+C */
	signal(SIGINT, sighandler);

	while (1) {
		cmdline = readline(show_prompt());
		parse_cmd(cmdline);
		/* Free the memory malloc'ed by readline */
		free(cmdline);
	}

	/* Should never reach here */
	return 0;
}
