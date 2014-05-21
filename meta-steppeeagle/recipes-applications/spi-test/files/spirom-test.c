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
#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <fcntl.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/types.h>

#include "spirom.h"

#define SPI_APP_VERSION		"0.1"

#define WREN		0x06
#define WRDI		0x04
#define RDSR		0x05
#define RDID		0x9F
#define CHIP_ERASE	0x60
#define SECTOR_ERASE	0x20
#define BLOCK_ERASE	0xD8
#define READ		0x03
#define WRITE		0x02

static void pabort(const char *s)
{
	perror(s);
	abort();
}

static const char *device = "/dev/spirom0.0";
static char command[20];
static int inputfile_fd;
static int outfile_fd;;
static unsigned long address;
static unsigned int num_bytes;

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

void parse_command(int fd)
{
	uint8_t cmd_byte;
	struct spi_ioc_transfer tr;
	unsigned int bytes_chunks;
	unsigned int remaining_bytes;
	int ret;

	/* Zero initialize spi_ioc_transfer */
	memset(&tr, 0, sizeof(struct spi_ioc_transfer));
	if ((strncmp(command, "WREN", 4) == 0) ||
	    (strncmp(command, "wren", 4) == 0)) {
		/* Command without data */
		tr.buf[0] = WREN;
		tr.direction = 0;
		tr.len = 0;
		tr.addr_present = 0;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");
	} else if ((strncmp(command, "WRDI", 4) == 0) ||
		   (strncmp(command, "wrdi", 4) == 0)) {
		/* Command without data */
		tr.buf[0] = WRDI;
		tr.direction = 0;
		tr.len = 0;
		tr.addr_present = 0;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");
	} else if ((strncmp(command, "CHIPERASE", 4) == 0) ||
		   (strncmp(command, "chiperase", 4) == 0)) {

		tr.buf[0] = RDSR;
		tr.direction = RECEIVE;
		tr.addr_present = 0;
		tr.len = 1;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");
		else if ((tr.buf[1] & 0x02) == 0x00) {
			printf("cannot execute command, write is disabled\n");
			exit(1);
		}

		/* Command without data */
		tr.buf[0] = CHIP_ERASE;
		tr.direction = 0;
		tr.len = 0;
		tr.addr_present = 0;
		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");

		/* Make sure WIP has been reset */
		while (1) {
			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = RDSR;
			tr.direction = RECEIVE;
			tr.addr_present = 0;
			tr.len = 1;

			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			if ((tr.buf[1] & 0x01) == 0x00)
				break;
		}
	} else if ((strncmp(command, "RDSR", 4) == 0) ||
		   (strncmp(command, "rdsr", 4) == 0)) {
		/* Command with response */
		tr.buf[0] = RDSR;
		tr.direction = RECEIVE;
		tr.addr_present = 0;
		tr.len = 1;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");

		/*
		 * The 1-byte response will be stored in tr.buf,
		 * so print it out
		 */
		printf("command: 0x%.2x response: 0x%.2x\n", tr.buf[0],
			tr.buf[1]);
	} else if ((strncmp(command, "RDID", 4) == 0) ||
		   (strncmp(command, "rdid", 4) == 0)) {
		/* Command with response */
		tr.buf[0] = RDID;
		tr.direction = RECEIVE;
		tr.addr_present = 0;
		tr.len = 3;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");

		/*
		 * The 3-bytes response will be stored in tr.buf,
		 * so print it out
		 */
		printf("command: 0x%.2x response: 0x%.2x%.2x%.2x\n", tr.buf[0],
			tr.buf[1], tr.buf[2], tr.buf[3]);
	} else if ((strncmp(command, "SECTORERASE", 6) ==0) ||
		   (strncmp(command, "sectorerase", 6) ==0)) {
		int i;

		tr.buf[0] = RDSR;
		tr.direction = RECEIVE;
		tr.addr_present = 0;
		tr.len = 1;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");
		else if ((tr.buf[1] & 0x02) == 0x00) {
			printf("cannot execute command, write is disabled\n");
			exit(1);
		}

		/*
		 * num_bytes here is a little bit of misnomer, it indicates the
		 * number of sectors to be erased, rather than the number of
		 * bytes to be erased.
		 */
		for (i = 0; i < num_bytes; i++) {
			/* Write Enable before Sector Erase */
			tr.buf[0] = WREN;
			tr.direction = 0;
			tr.len = 0;
			tr.addr_present = 0;
			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			/* Command with address but no data */
			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = SECTOR_ERASE;
			tr.buf[3] = address & 0xff;
			tr.buf[2] = (address >> 8) & 0xff;
			tr.buf[1] = (address >> 16) & 0xff;
			tr.addr_present = 1;
			tr.direction = 0;
			tr.len = 0;

			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			/* point to the next 4k block */
			address += 4 * 1024;

			/*
			 * Before the next loop, we need to make sure that WIP
			 * bit in the output of RDSR has been reset.
			 */
			while (1) {
				memset(&tr, 0, sizeof(struct spi_ioc_transfer));
				tr.buf[0] = RDSR;
				tr.direction = RECEIVE;
				tr.addr_present = 0;
				tr.len = 1;

				ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
				if (ret < 1)
					pabort("can't send spi message");

				if ((tr.buf[1] & 0x01) == 0x00)
					break;
			}
		}
	} else if ((strncmp(command, "BLOCKERASE", 5) == 0) ||
		   (strncmp(command, "blockerase", 5) == 0)) {
		int i;

		tr.buf[0] = RDSR;
		tr.direction = RECEIVE;
		tr.addr_present = 0;
		tr.len = 1;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");
		else if ((tr.buf[1] & 0x02) == 0x00) {
			printf("cannot execute command, write is disabled\n");
			exit(1);
		}

		/*
		 * num_bytes indicates the number of blocks to be erased,
		 * rather than the number of bytes to be erased.
		 */
		for (i = 0; i < num_bytes; i++) {
			/* Write Enable before Block Erase */
			tr.buf[0] = WREN;
			tr.direction = 0;
			tr.len = 0;
			tr.addr_present = 0;
			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			/* Command with address but no data */
			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = BLOCK_ERASE;
			tr.buf[3] = address & 0xff;
			tr.buf[2] = (address >> 8) & 0xff;
			tr.buf[1] = (address >> 16) & 0xff;
			tr.addr_present = 1;
			tr.direction = 0;
			tr.len = 0;

			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			/* point to the next 64k block */
			address += 64 * 1024;

			/*
			 * Before the next loop, we need to make sure that WIP
			 * bit in the output of RDSR has been reset.
			 */
			while (1) {
				memset(&tr, 0, sizeof(struct spi_ioc_transfer));
				tr.buf[0] = RDSR;
				tr.direction = RECEIVE;
				tr.addr_present = 0;
				tr.len = 1;

				ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
				if (ret < 1)
					pabort("can't send spi message");

				if ((tr.buf[1] & 0x01) == 0x00)
					break;
			}
		}
	} else if ((strncmp(command, "READ", 4) == 0) ||
		   (strncmp(command, "read", 4) ==0)) {
		int i;

		/*
		 * We will break down the bytes to be received in chunks of
		 * of 64-bytes. Data might not be a even multiple of 64. So
		 * in that case, we will have some remaining bytes <64. We
		 * handle that separately.
		 */
		bytes_chunks = num_bytes / 64;
		remaining_bytes = num_bytes % 64;

		for (i = 0; i < bytes_chunks; i++) {
			/* Command with address and data */
			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = READ;
			tr.direction = RECEIVE;
			/*
			 * We will store the address into the buffer in little
			 * endian order.
			 */
			tr.buf[3] = address & 0xff;
			tr.buf[2] = (address >> 8) & 0xff;
			tr.buf[1] = (address >> 16) & 0xff;
			tr.len = 64;
			tr.addr_present = 1;

			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			/* Write the data read to output file */
			if (write(outfile_fd, &tr.buf[4], tr.len) < 0) {
				perror("write error");
				exit(1);
			}
			address += 64;
		}

		if (remaining_bytes) {
			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = READ;
			tr.direction = RECEIVE;
			tr.buf[3] = address & 0xff;
			tr.buf[2] = (address >> 8) & 0xff;
			tr.buf[1] = (address >> 16) & 0xff;
			tr.len = remaining_bytes;
			tr.addr_present = 1;

			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			if (write(outfile_fd, &tr.buf[4], tr.len) < 0) {
				perror("write error");
				exit(1);
			}
		}
	} else if ((strncmp(command, "WRITE", 5) == 0) ||
		   (strncmp(command, "write", 5) ==0)) {
		int i;

		/*
		 * We will break down the bytes to be transmitted in chunks of
		 * of 64-bytes. Like for read, we might not have data in an
		 * even multiple of 64 bytes. So we will handle the remaining
		 * bytes in the end.
		 */

		tr.buf[0] = RDSR;
		tr.direction = RECEIVE;
		tr.addr_present = 0;
		tr.len = 1;

		ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
		if (ret < 1)
			pabort("can't send spi message");
		else if ((tr.buf[1] & 0x02) == 0x00) {
			printf("cannot execute command, write is disabled\n");
			exit(1);
		}

		bytes_chunks = num_bytes / 64;
		remaining_bytes = num_bytes % 64;

		for (i = 0; i < bytes_chunks; i++) {
			tr.buf[0] = WREN;
			tr.direction = 0;
			tr.len = 0;
			tr.addr_present = 0;
			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			/* Command with data and address */
			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = WRITE;
			tr.direction = TRANSMIT;
			/*
			 * We will store the address into the buffer in little
			 * endian order.
			 */
			tr.buf[3] = address & 0xff;
			tr.buf[2] = (address >> 8) & 0xff;
			tr.buf[1] = (address >> 16) & 0xff;
			tr.len = 64;
			tr.addr_present = 1;

			/* Read 64 bytes from inputfile to buffer */
			if (read(inputfile_fd, &tr.buf[4], tr.len) < 0) {
				perror("read error");
				exit(1);
			}
			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			address += 64;

			/*
			 * Before the next loop, we need to make sure that WIP
			 * bit in the output of RDSR has been reset.
			 */
			while (1) {
				memset(&tr, 0, sizeof(struct spi_ioc_transfer));
				tr.buf[0] = RDSR;
				tr.direction = RECEIVE;
				tr.addr_present = 0;
				tr.len = 1;

				ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
				if (ret < 1)
					pabort("can't send spi message");

				if ((tr.buf[1] & 0x01) == 0x00)
					break;
			}
		}

		if (remaining_bytes) {
			tr.buf[0] = WREN;
			tr.direction = 0;
			tr.len = 0;
			tr.addr_present = 0;
			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			memset(&tr, 0, sizeof(struct spi_ioc_transfer));
			tr.buf[0] = WRITE;
			tr.direction = TRANSMIT;
			tr.buf[3] = address & 0xff;
			tr.buf[2] = (address >> 8) & 0xff;
			tr.buf[1] = (address >> 16) & 0xff;
			tr.len = remaining_bytes;
			tr.addr_present = 1;

			if (read(inputfile_fd, &tr.buf[4], tr.len) < 0) {
				perror("read error");
				exit(1);
			}
			ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
			if (ret < 1)
				pabort("can't send spi message");

			while (1) {
				memset(&tr, 0, sizeof(struct spi_ioc_transfer));
				tr.buf[0] = RDSR;
				tr.direction = RECEIVE;
				tr.addr_present = 0;
				tr.len = 1;

				ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
				if (ret < 1)
					pabort("can't send spi message");

				if ((tr.buf[1] & 0x01) == 0x00)
					break;
			}
		}
	} else
		pabort("Unrecognized command, please try again.\n");
}

static void print_usage(const char *prog)
{
	printf("\nUsage: sudo %s [-DCAnio] [arguments]\n\n", prog);
	puts("  -D --device        SPI ROM device to use\n"
	     "                    (default /dev/spirom0.0)\n\n"
	     "  -C --command       command to send to the device\n"
	     "                    (WREN/WRDI/RDSR/RDID/CHIPERASE/SECTORERASE/\n"
	     "                     BLOCKERASE/READ/WRITE)\n\n"
	     "  -A --address       offset in decimal, into the device to read\n"
	     "                     from or write to. For a ROM size of 8MB,\n"
	     "                     address can go from 0 to 8388608. Negative\n"
	     "                     offsets are not valid, but the program\n"
	     "                     won't complain and convert it to its\n"
	     "                     unsigned equivalent.\n\n"
	     "  -n --num-bytes     number of bytes to be read from or written\n"
	     "                     to. Depending on the address, this can\n"
	     "                     take values from 0 to 8388608 for a ROM\n"
	     "                     size of 8MB.\n\n"
	     "                     In case of SECTORERASE and BLOCKERASE\n"
	     "                     commands, num-bytes actually takes the\n"
	     "                     number of sectors and blocks to be erased\n"
	     "                     respectively, rather than the number of\n"
	     "                     bytes.\n\n"
	     "  -i --input-file    file to be used as input.\n\n"
	     "  -o --output-file   file to be used for output. Remember that if\n"
	     "                     an existing filename is given, its contents\n"
	     "                     will be overwritten.\n"
	     "  -l --license       displays the terms of LICENSE for this application\n\n");
	exit(1);
}

static void parse_opts(int argc, char *argv[])
{
	if (argc == 1)
		print_usage(argv[0]);

	while (1) {
		static const struct option lopts[] = {
			{ "device",  1, 0, 'D' },
			{ "command", 1, 0, 'C' },
			{ "address", 1, 0, 'A' },
			{ "num-bytes", 1, 0, 'n' },
			{ "input-file", 1, 0, 'i' },
			{ "output-file", 1, 0, 'o' },
			{ "license", 0, 0, 'l' },
			{ NULL, 0, 0, 0 },
		};
		int c;

		c = getopt_long(argc, argv, "D:C:A:n:i:o:l", lopts, NULL);

		if (c == -1)
			break;

		switch (c) {
		case 'D':
			device = optarg;
			break;
		case 'C':
			memset(command, sizeof(command), 0);
			strncpy(command, optarg, sizeof(command));
			break;
		case 'A':
			address = atol(optarg);
			break;
		case 'n':
			num_bytes = atoi(optarg);
			break;
		case 'i':
			inputfile_fd = open(optarg, O_RDONLY);
			if (inputfile_fd < 0) {
				printf("Error opening %s\n", optarg);
				exit(1);
			}
			break;
		case 'o':
			outfile_fd = open(optarg, O_WRONLY | O_CREAT |
					O_TRUNC, 0644);
			if(outfile_fd < 0) {
				printf("Error opening %s\n", optarg);
				exit(1);
			}
			break;
		case 'l':
			show_license();
			exit(0);;
		default:
			print_usage(argv[0]);
			break;
		}
	}
}

int main(int argc, char *argv[])
{
	int ret = 0;
	int fd;

	printf("SPI sample application version: %s\n", SPI_APP_VERSION);
	printf("Copyright (c) 2014, Advanced Micro Devices, Inc.\n"
	       "This sample application comes with ABSOLUTELY NO WARRANTY;\n"
	       "This is free software, and you are welcome to redistribute it\n"
	       "under certain conditions; type `license' for details.\n\n");

	parse_opts(argc, argv);

	fd = open(device, O_RDWR);
	if (fd < 0)
		pabort("can't open device");

	parse_command(fd);

	return ret;
}
