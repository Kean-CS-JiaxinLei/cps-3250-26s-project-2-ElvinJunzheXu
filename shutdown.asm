
_shutdown:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    printf(1, "BYEBYE XV6\n");
  11:	83 ec 08             	sub    $0x8,%esp
  14:	68 b7 07 00 00       	push   $0x7b7
  19:	6a 01                	push   $0x1
  1b:	e8 e0 03 00 00       	call   400 <printf>
  20:	83 c4 10             	add    $0x10,%esp

    shutdown();
  23:	e8 fc 02 00 00       	call   324 <shutdown>


    exit();
  28:	e8 57 02 00 00       	call   284 <exit>

0000002d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2d:	55                   	push   %ebp
  2e:	89 e5                	mov    %esp,%ebp
  30:	57                   	push   %edi
  31:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  32:	8b 4d 08             	mov    0x8(%ebp),%ecx
  35:	8b 55 10             	mov    0x10(%ebp),%edx
  38:	8b 45 0c             	mov    0xc(%ebp),%eax
  3b:	89 cb                	mov    %ecx,%ebx
  3d:	89 df                	mov    %ebx,%edi
  3f:	89 d1                	mov    %edx,%ecx
  41:	fc                   	cld
  42:	f3 aa                	rep stos %al,%es:(%edi)
  44:	89 ca                	mov    %ecx,%edx
  46:	89 fb                	mov    %edi,%ebx
  48:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4b:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4e:	90                   	nop
  4f:	5b                   	pop    %ebx
  50:	5f                   	pop    %edi
  51:	5d                   	pop    %ebp
  52:	c3                   	ret

00000053 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  53:	55                   	push   %ebp
  54:	89 e5                	mov    %esp,%ebp
  56:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  59:	8b 45 08             	mov    0x8(%ebp),%eax
  5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5f:	90                   	nop
  60:	8b 55 0c             	mov    0xc(%ebp),%edx
  63:	8d 42 01             	lea    0x1(%edx),%eax
  66:	89 45 0c             	mov    %eax,0xc(%ebp)
  69:	8b 45 08             	mov    0x8(%ebp),%eax
  6c:	8d 48 01             	lea    0x1(%eax),%ecx
  6f:	89 4d 08             	mov    %ecx,0x8(%ebp)
  72:	0f b6 12             	movzbl (%edx),%edx
  75:	88 10                	mov    %dl,(%eax)
  77:	0f b6 00             	movzbl (%eax),%eax
  7a:	84 c0                	test   %al,%al
  7c:	75 e2                	jne    60 <strcpy+0xd>
    ;
  return os;
  7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  81:	c9                   	leave
  82:	c3                   	ret

00000083 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  83:	55                   	push   %ebp
  84:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  86:	eb 08                	jmp    90 <strcmp+0xd>
    p++, q++;
  88:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  90:	8b 45 08             	mov    0x8(%ebp),%eax
  93:	0f b6 00             	movzbl (%eax),%eax
  96:	84 c0                	test   %al,%al
  98:	74 10                	je     aa <strcmp+0x27>
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	0f b6 10             	movzbl (%eax),%edx
  a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  a3:	0f b6 00             	movzbl (%eax),%eax
  a6:	38 c2                	cmp    %al,%dl
  a8:	74 de                	je     88 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  aa:	8b 45 08             	mov    0x8(%ebp),%eax
  ad:	0f b6 00             	movzbl (%eax),%eax
  b0:	0f b6 d0             	movzbl %al,%edx
  b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  b6:	0f b6 00             	movzbl (%eax),%eax
  b9:	0f b6 c0             	movzbl %al,%eax
  bc:	29 c2                	sub    %eax,%edx
  be:	89 d0                	mov    %edx,%eax
}
  c0:	5d                   	pop    %ebp
  c1:	c3                   	ret

000000c2 <strlen>:

uint
strlen(char *s)
{
  c2:	55                   	push   %ebp
  c3:	89 e5                	mov    %esp,%ebp
  c5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cf:	eb 04                	jmp    d5 <strlen+0x13>
  d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	01 d0                	add    %edx,%eax
  dd:	0f b6 00             	movzbl (%eax),%eax
  e0:	84 c0                	test   %al,%al
  e2:	75 ed                	jne    d1 <strlen+0xf>
    ;
  return n;
  e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e7:	c9                   	leave
  e8:	c3                   	ret

000000e9 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e9:	55                   	push   %ebp
  ea:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  ec:	8b 45 10             	mov    0x10(%ebp),%eax
  ef:	50                   	push   %eax
  f0:	ff 75 0c             	push   0xc(%ebp)
  f3:	ff 75 08             	push   0x8(%ebp)
  f6:	e8 32 ff ff ff       	call   2d <stosb>
  fb:	83 c4 0c             	add    $0xc,%esp
  return dst;
  fe:	8b 45 08             	mov    0x8(%ebp),%eax
}
 101:	c9                   	leave
 102:	c3                   	ret

00000103 <strchr>:

char*
strchr(const char *s, char c)
{
 103:	55                   	push   %ebp
 104:	89 e5                	mov    %esp,%ebp
 106:	83 ec 04             	sub    $0x4,%esp
 109:	8b 45 0c             	mov    0xc(%ebp),%eax
 10c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10f:	eb 14                	jmp    125 <strchr+0x22>
    if(*s == c)
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	0f b6 00             	movzbl (%eax),%eax
 117:	38 45 fc             	cmp    %al,-0x4(%ebp)
 11a:	75 05                	jne    121 <strchr+0x1e>
      return (char*)s;
 11c:	8b 45 08             	mov    0x8(%ebp),%eax
 11f:	eb 13                	jmp    134 <strchr+0x31>
  for(; *s; s++)
 121:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	0f b6 00             	movzbl (%eax),%eax
 12b:	84 c0                	test   %al,%al
 12d:	75 e2                	jne    111 <strchr+0xe>
  return 0;
 12f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 134:	c9                   	leave
 135:	c3                   	ret

00000136 <gets>:

char*
gets(char *buf, int max)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
 139:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 143:	eb 42                	jmp    187 <gets+0x51>
    cc = read(0, &c, 1);
 145:	83 ec 04             	sub    $0x4,%esp
 148:	6a 01                	push   $0x1
 14a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14d:	50                   	push   %eax
 14e:	6a 00                	push   $0x0
 150:	e8 47 01 00 00       	call   29c <read>
 155:	83 c4 10             	add    $0x10,%esp
 158:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 15b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 15f:	7e 33                	jle    194 <gets+0x5e>
      break;
    buf[i++] = c;
 161:	8b 45 f4             	mov    -0xc(%ebp),%eax
 164:	8d 50 01             	lea    0x1(%eax),%edx
 167:	89 55 f4             	mov    %edx,-0xc(%ebp)
 16a:	89 c2                	mov    %eax,%edx
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	01 c2                	add    %eax,%edx
 171:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 175:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 177:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17b:	3c 0a                	cmp    $0xa,%al
 17d:	74 16                	je     195 <gets+0x5f>
 17f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 183:	3c 0d                	cmp    $0xd,%al
 185:	74 0e                	je     195 <gets+0x5f>
  for(i=0; i+1 < max; ){
 187:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18a:	83 c0 01             	add    $0x1,%eax
 18d:	39 45 0c             	cmp    %eax,0xc(%ebp)
 190:	7f b3                	jg     145 <gets+0xf>
 192:	eb 01                	jmp    195 <gets+0x5f>
      break;
 194:	90                   	nop
      break;
  }
  buf[i] = '\0';
 195:	8b 55 f4             	mov    -0xc(%ebp),%edx
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	01 d0                	add    %edx,%eax
 19d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a3:	c9                   	leave
 1a4:	c3                   	ret

000001a5 <stat>:

int
stat(char *n, struct stat *st)
{
 1a5:	55                   	push   %ebp
 1a6:	89 e5                	mov    %esp,%ebp
 1a8:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ab:	83 ec 08             	sub    $0x8,%esp
 1ae:	6a 00                	push   $0x0
 1b0:	ff 75 08             	push   0x8(%ebp)
 1b3:	e8 0c 01 00 00       	call   2c4 <open>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c2:	79 07                	jns    1cb <stat+0x26>
    return -1;
 1c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c9:	eb 25                	jmp    1f0 <stat+0x4b>
  r = fstat(fd, st);
 1cb:	83 ec 08             	sub    $0x8,%esp
 1ce:	ff 75 0c             	push   0xc(%ebp)
 1d1:	ff 75 f4             	push   -0xc(%ebp)
 1d4:	e8 03 01 00 00       	call   2dc <fstat>
 1d9:	83 c4 10             	add    $0x10,%esp
 1dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1df:	83 ec 0c             	sub    $0xc,%esp
 1e2:	ff 75 f4             	push   -0xc(%ebp)
 1e5:	e8 c2 00 00 00       	call   2ac <close>
 1ea:	83 c4 10             	add    $0x10,%esp
  return r;
 1ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f0:	c9                   	leave
 1f1:	c3                   	ret

000001f2 <atoi>:

int
atoi(const char *s)
{
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1ff:	eb 25                	jmp    226 <atoi+0x34>
    n = n*10 + *s++ - '0';
 201:	8b 55 fc             	mov    -0x4(%ebp),%edx
 204:	89 d0                	mov    %edx,%eax
 206:	c1 e0 02             	shl    $0x2,%eax
 209:	01 d0                	add    %edx,%eax
 20b:	01 c0                	add    %eax,%eax
 20d:	89 c1                	mov    %eax,%ecx
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	8d 50 01             	lea    0x1(%eax),%edx
 215:	89 55 08             	mov    %edx,0x8(%ebp)
 218:	0f b6 00             	movzbl (%eax),%eax
 21b:	0f be c0             	movsbl %al,%eax
 21e:	01 c8                	add    %ecx,%eax
 220:	83 e8 30             	sub    $0x30,%eax
 223:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	0f b6 00             	movzbl (%eax),%eax
 22c:	3c 2f                	cmp    $0x2f,%al
 22e:	7e 0a                	jle    23a <atoi+0x48>
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	0f b6 00             	movzbl (%eax),%eax
 236:	3c 39                	cmp    $0x39,%al
 238:	7e c7                	jle    201 <atoi+0xf>
  return n;
 23a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23d:	c9                   	leave
 23e:	c3                   	ret

0000023f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 23f:	55                   	push   %ebp
 240:	89 e5                	mov    %esp,%ebp
 242:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24b:	8b 45 0c             	mov    0xc(%ebp),%eax
 24e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 251:	eb 17                	jmp    26a <memmove+0x2b>
    *dst++ = *src++;
 253:	8b 55 f8             	mov    -0x8(%ebp),%edx
 256:	8d 42 01             	lea    0x1(%edx),%eax
 259:	89 45 f8             	mov    %eax,-0x8(%ebp)
 25c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25f:	8d 48 01             	lea    0x1(%eax),%ecx
 262:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 265:	0f b6 12             	movzbl (%edx),%edx
 268:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 26a:	8b 45 10             	mov    0x10(%ebp),%eax
 26d:	8d 50 ff             	lea    -0x1(%eax),%edx
 270:	89 55 10             	mov    %edx,0x10(%ebp)
 273:	85 c0                	test   %eax,%eax
 275:	7f dc                	jg     253 <memmove+0x14>
  return vdst;
 277:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27a:	c9                   	leave
 27b:	c3                   	ret

0000027c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27c:	b8 01 00 00 00       	mov    $0x1,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret

00000284 <exit>:
SYSCALL(exit)
 284:	b8 02 00 00 00       	mov    $0x2,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret

0000028c <wait>:
SYSCALL(wait)
 28c:	b8 03 00 00 00       	mov    $0x3,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret

00000294 <pipe>:
SYSCALL(pipe)
 294:	b8 04 00 00 00       	mov    $0x4,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret

0000029c <read>:
SYSCALL(read)
 29c:	b8 05 00 00 00       	mov    $0x5,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret

000002a4 <write>:
SYSCALL(write)
 2a4:	b8 10 00 00 00       	mov    $0x10,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret

000002ac <close>:
SYSCALL(close)
 2ac:	b8 15 00 00 00       	mov    $0x15,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret

000002b4 <kill>:
SYSCALL(kill)
 2b4:	b8 06 00 00 00       	mov    $0x6,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret

000002bc <exec>:
SYSCALL(exec)
 2bc:	b8 07 00 00 00       	mov    $0x7,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret

000002c4 <open>:
SYSCALL(open)
 2c4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret

000002cc <mknod>:
SYSCALL(mknod)
 2cc:	b8 11 00 00 00       	mov    $0x11,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret

000002d4 <unlink>:
SYSCALL(unlink)
 2d4:	b8 12 00 00 00       	mov    $0x12,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret

000002dc <fstat>:
SYSCALL(fstat)
 2dc:	b8 08 00 00 00       	mov    $0x8,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret

000002e4 <link>:
SYSCALL(link)
 2e4:	b8 13 00 00 00       	mov    $0x13,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret

000002ec <mkdir>:
SYSCALL(mkdir)
 2ec:	b8 14 00 00 00       	mov    $0x14,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret

000002f4 <chdir>:
SYSCALL(chdir)
 2f4:	b8 09 00 00 00       	mov    $0x9,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret

000002fc <dup>:
SYSCALL(dup)
 2fc:	b8 0a 00 00 00       	mov    $0xa,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret

00000304 <getpid>:
SYSCALL(getpid)
 304:	b8 0b 00 00 00       	mov    $0xb,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret

0000030c <sbrk>:
SYSCALL(sbrk)
 30c:	b8 0c 00 00 00       	mov    $0xc,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret

00000314 <sleep>:
SYSCALL(sleep)
 314:	b8 0d 00 00 00       	mov    $0xd,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret

0000031c <uptime>:
SYSCALL(uptime)
 31c:	b8 0e 00 00 00       	mov    $0xe,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret

00000324 <shutdown>:
SYSCALL(shutdown)
 324:	b8 16 00 00 00       	mov    $0x16,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret

0000032c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	83 ec 18             	sub    $0x18,%esp
 332:	8b 45 0c             	mov    0xc(%ebp),%eax
 335:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 338:	83 ec 04             	sub    $0x4,%esp
 33b:	6a 01                	push   $0x1
 33d:	8d 45 f4             	lea    -0xc(%ebp),%eax
 340:	50                   	push   %eax
 341:	ff 75 08             	push   0x8(%ebp)
 344:	e8 5b ff ff ff       	call   2a4 <write>
 349:	83 c4 10             	add    $0x10,%esp
}
 34c:	90                   	nop
 34d:	c9                   	leave
 34e:	c3                   	ret

0000034f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 34f:	55                   	push   %ebp
 350:	89 e5                	mov    %esp,%ebp
 352:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 355:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 35c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 360:	74 17                	je     379 <printint+0x2a>
 362:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 366:	79 11                	jns    379 <printint+0x2a>
    neg = 1;
 368:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 36f:	8b 45 0c             	mov    0xc(%ebp),%eax
 372:	f7 d8                	neg    %eax
 374:	89 45 ec             	mov    %eax,-0x14(%ebp)
 377:	eb 06                	jmp    37f <printint+0x30>
  } else {
    x = xx;
 379:	8b 45 0c             	mov    0xc(%ebp),%eax
 37c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 37f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 386:	8b 4d 10             	mov    0x10(%ebp),%ecx
 389:	8b 45 ec             	mov    -0x14(%ebp),%eax
 38c:	ba 00 00 00 00       	mov    $0x0,%edx
 391:	f7 f1                	div    %ecx
 393:	89 d1                	mov    %edx,%ecx
 395:	8b 45 f4             	mov    -0xc(%ebp),%eax
 398:	8d 50 01             	lea    0x1(%eax),%edx
 39b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 39e:	0f b6 91 10 0a 00 00 	movzbl 0xa10(%ecx),%edx
 3a5:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3af:	ba 00 00 00 00       	mov    $0x0,%edx
 3b4:	f7 f1                	div    %ecx
 3b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3bd:	75 c7                	jne    386 <printint+0x37>
  if(neg)
 3bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3c3:	74 2d                	je     3f2 <printint+0xa3>
    buf[i++] = '-';
 3c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3c8:	8d 50 01             	lea    0x1(%eax),%edx
 3cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ce:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3d3:	eb 1d                	jmp    3f2 <printint+0xa3>
    putc(fd, buf[i]);
 3d5:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3db:	01 d0                	add    %edx,%eax
 3dd:	0f b6 00             	movzbl (%eax),%eax
 3e0:	0f be c0             	movsbl %al,%eax
 3e3:	83 ec 08             	sub    $0x8,%esp
 3e6:	50                   	push   %eax
 3e7:	ff 75 08             	push   0x8(%ebp)
 3ea:	e8 3d ff ff ff       	call   32c <putc>
 3ef:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 3f2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3fa:	79 d9                	jns    3d5 <printint+0x86>
}
 3fc:	90                   	nop
 3fd:	90                   	nop
 3fe:	c9                   	leave
 3ff:	c3                   	ret

00000400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 406:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 40d:	8d 45 0c             	lea    0xc(%ebp),%eax
 410:	83 c0 04             	add    $0x4,%eax
 413:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 416:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 41d:	e9 59 01 00 00       	jmp    57b <printf+0x17b>
    c = fmt[i] & 0xff;
 422:	8b 55 0c             	mov    0xc(%ebp),%edx
 425:	8b 45 f0             	mov    -0x10(%ebp),%eax
 428:	01 d0                	add    %edx,%eax
 42a:	0f b6 00             	movzbl (%eax),%eax
 42d:	0f be c0             	movsbl %al,%eax
 430:	25 ff 00 00 00       	and    $0xff,%eax
 435:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 438:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43c:	75 2c                	jne    46a <printf+0x6a>
      if(c == '%'){
 43e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 442:	75 0c                	jne    450 <printf+0x50>
        state = '%';
 444:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 44b:	e9 27 01 00 00       	jmp    577 <printf+0x177>
      } else {
        putc(fd, c);
 450:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 453:	0f be c0             	movsbl %al,%eax
 456:	83 ec 08             	sub    $0x8,%esp
 459:	50                   	push   %eax
 45a:	ff 75 08             	push   0x8(%ebp)
 45d:	e8 ca fe ff ff       	call   32c <putc>
 462:	83 c4 10             	add    $0x10,%esp
 465:	e9 0d 01 00 00       	jmp    577 <printf+0x177>
      }
    } else if(state == '%'){
 46a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 46e:	0f 85 03 01 00 00    	jne    577 <printf+0x177>
      if(c == 'd'){
 474:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 478:	75 1e                	jne    498 <printf+0x98>
        printint(fd, *ap, 10, 1);
 47a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 47d:	8b 00                	mov    (%eax),%eax
 47f:	6a 01                	push   $0x1
 481:	6a 0a                	push   $0xa
 483:	50                   	push   %eax
 484:	ff 75 08             	push   0x8(%ebp)
 487:	e8 c3 fe ff ff       	call   34f <printint>
 48c:	83 c4 10             	add    $0x10,%esp
        ap++;
 48f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 493:	e9 d8 00 00 00       	jmp    570 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 498:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 49c:	74 06                	je     4a4 <printf+0xa4>
 49e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4a2:	75 1e                	jne    4c2 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a7:	8b 00                	mov    (%eax),%eax
 4a9:	6a 00                	push   $0x0
 4ab:	6a 10                	push   $0x10
 4ad:	50                   	push   %eax
 4ae:	ff 75 08             	push   0x8(%ebp)
 4b1:	e8 99 fe ff ff       	call   34f <printint>
 4b6:	83 c4 10             	add    $0x10,%esp
        ap++;
 4b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4bd:	e9 ae 00 00 00       	jmp    570 <printf+0x170>
      } else if(c == 's'){
 4c2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4c6:	75 43                	jne    50b <printf+0x10b>
        s = (char*)*ap;
 4c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4cb:	8b 00                	mov    (%eax),%eax
 4cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d8:	75 25                	jne    4ff <printf+0xff>
          s = "(null)";
 4da:	c7 45 f4 c3 07 00 00 	movl   $0x7c3,-0xc(%ebp)
        while(*s != 0){
 4e1:	eb 1c                	jmp    4ff <printf+0xff>
          putc(fd, *s);
 4e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e6:	0f b6 00             	movzbl (%eax),%eax
 4e9:	0f be c0             	movsbl %al,%eax
 4ec:	83 ec 08             	sub    $0x8,%esp
 4ef:	50                   	push   %eax
 4f0:	ff 75 08             	push   0x8(%ebp)
 4f3:	e8 34 fe ff ff       	call   32c <putc>
 4f8:	83 c4 10             	add    $0x10,%esp
          s++;
 4fb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 4ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 502:	0f b6 00             	movzbl (%eax),%eax
 505:	84 c0                	test   %al,%al
 507:	75 da                	jne    4e3 <printf+0xe3>
 509:	eb 65                	jmp    570 <printf+0x170>
        }
      } else if(c == 'c'){
 50b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 50f:	75 1d                	jne    52e <printf+0x12e>
        putc(fd, *ap);
 511:	8b 45 e8             	mov    -0x18(%ebp),%eax
 514:	8b 00                	mov    (%eax),%eax
 516:	0f be c0             	movsbl %al,%eax
 519:	83 ec 08             	sub    $0x8,%esp
 51c:	50                   	push   %eax
 51d:	ff 75 08             	push   0x8(%ebp)
 520:	e8 07 fe ff ff       	call   32c <putc>
 525:	83 c4 10             	add    $0x10,%esp
        ap++;
 528:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52c:	eb 42                	jmp    570 <printf+0x170>
      } else if(c == '%'){
 52e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 532:	75 17                	jne    54b <printf+0x14b>
        putc(fd, c);
 534:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 537:	0f be c0             	movsbl %al,%eax
 53a:	83 ec 08             	sub    $0x8,%esp
 53d:	50                   	push   %eax
 53e:	ff 75 08             	push   0x8(%ebp)
 541:	e8 e6 fd ff ff       	call   32c <putc>
 546:	83 c4 10             	add    $0x10,%esp
 549:	eb 25                	jmp    570 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 54b:	83 ec 08             	sub    $0x8,%esp
 54e:	6a 25                	push   $0x25
 550:	ff 75 08             	push   0x8(%ebp)
 553:	e8 d4 fd ff ff       	call   32c <putc>
 558:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 55b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 55e:	0f be c0             	movsbl %al,%eax
 561:	83 ec 08             	sub    $0x8,%esp
 564:	50                   	push   %eax
 565:	ff 75 08             	push   0x8(%ebp)
 568:	e8 bf fd ff ff       	call   32c <putc>
 56d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 570:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 577:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 57b:	8b 55 0c             	mov    0xc(%ebp),%edx
 57e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 581:	01 d0                	add    %edx,%eax
 583:	0f b6 00             	movzbl (%eax),%eax
 586:	84 c0                	test   %al,%al
 588:	0f 85 94 fe ff ff    	jne    422 <printf+0x22>
    }
  }
}
 58e:	90                   	nop
 58f:	90                   	nop
 590:	c9                   	leave
 591:	c3                   	ret

00000592 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 592:	55                   	push   %ebp
 593:	89 e5                	mov    %esp,%ebp
 595:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 598:	8b 45 08             	mov    0x8(%ebp),%eax
 59b:	83 e8 08             	sub    $0x8,%eax
 59e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a1:	a1 2c 0a 00 00       	mov    0xa2c,%eax
 5a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5a9:	eb 24                	jmp    5cf <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ae:	8b 00                	mov    (%eax),%eax
 5b0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5b3:	72 12                	jb     5c7 <free+0x35>
 5b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b8:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5bb:	72 24                	jb     5e1 <free+0x4f>
 5bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c0:	8b 00                	mov    (%eax),%eax
 5c2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5c5:	72 1a                	jb     5e1 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ca:	8b 00                	mov    (%eax),%eax
 5cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d2:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5d5:	73 d4                	jae    5ab <free+0x19>
 5d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5da:	8b 00                	mov    (%eax),%eax
 5dc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5df:	73 ca                	jae    5ab <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e4:	8b 40 04             	mov    0x4(%eax),%eax
 5e7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f1:	01 c2                	add    %eax,%edx
 5f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f6:	8b 00                	mov    (%eax),%eax
 5f8:	39 c2                	cmp    %eax,%edx
 5fa:	75 24                	jne    620 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ff:	8b 50 04             	mov    0x4(%eax),%edx
 602:	8b 45 fc             	mov    -0x4(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	8b 40 04             	mov    0x4(%eax),%eax
 60a:	01 c2                	add    %eax,%edx
 60c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 612:	8b 45 fc             	mov    -0x4(%ebp),%eax
 615:	8b 00                	mov    (%eax),%eax
 617:	8b 10                	mov    (%eax),%edx
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	89 10                	mov    %edx,(%eax)
 61e:	eb 0a                	jmp    62a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 620:	8b 45 fc             	mov    -0x4(%ebp),%eax
 623:	8b 10                	mov    (%eax),%edx
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 62a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62d:	8b 40 04             	mov    0x4(%eax),%eax
 630:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 637:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63a:	01 d0                	add    %edx,%eax
 63c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 63f:	75 20                	jne    661 <free+0xcf>
    p->s.size += bp->s.size;
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	8b 50 04             	mov    0x4(%eax),%edx
 647:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64a:	8b 40 04             	mov    0x4(%eax),%eax
 64d:	01 c2                	add    %eax,%edx
 64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 652:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 655:	8b 45 f8             	mov    -0x8(%ebp),%eax
 658:	8b 10                	mov    (%eax),%edx
 65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65d:	89 10                	mov    %edx,(%eax)
 65f:	eb 08                	jmp    669 <free+0xd7>
  } else
    p->s.ptr = bp;
 661:	8b 45 fc             	mov    -0x4(%ebp),%eax
 664:	8b 55 f8             	mov    -0x8(%ebp),%edx
 667:	89 10                	mov    %edx,(%eax)
  freep = p;
 669:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66c:	a3 2c 0a 00 00       	mov    %eax,0xa2c
}
 671:	90                   	nop
 672:	c9                   	leave
 673:	c3                   	ret

00000674 <morecore>:

static Header*
morecore(uint nu)
{
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 67a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 681:	77 07                	ja     68a <morecore+0x16>
    nu = 4096;
 683:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 68a:	8b 45 08             	mov    0x8(%ebp),%eax
 68d:	c1 e0 03             	shl    $0x3,%eax
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	50                   	push   %eax
 694:	e8 73 fc ff ff       	call   30c <sbrk>
 699:	83 c4 10             	add    $0x10,%esp
 69c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 69f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6a3:	75 07                	jne    6ac <morecore+0x38>
    return 0;
 6a5:	b8 00 00 00 00       	mov    $0x0,%eax
 6aa:	eb 26                	jmp    6d2 <morecore+0x5e>
  hp = (Header*)p;
 6ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b5:	8b 55 08             	mov    0x8(%ebp),%edx
 6b8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6be:	83 c0 08             	add    $0x8,%eax
 6c1:	83 ec 0c             	sub    $0xc,%esp
 6c4:	50                   	push   %eax
 6c5:	e8 c8 fe ff ff       	call   592 <free>
 6ca:	83 c4 10             	add    $0x10,%esp
  return freep;
 6cd:	a1 2c 0a 00 00       	mov    0xa2c,%eax
}
 6d2:	c9                   	leave
 6d3:	c3                   	ret

000006d4 <malloc>:

void*
malloc(uint nbytes)
{
 6d4:	55                   	push   %ebp
 6d5:	89 e5                	mov    %esp,%ebp
 6d7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6da:	8b 45 08             	mov    0x8(%ebp),%eax
 6dd:	83 c0 07             	add    $0x7,%eax
 6e0:	c1 e8 03             	shr    $0x3,%eax
 6e3:	83 c0 01             	add    $0x1,%eax
 6e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6e9:	a1 2c 0a 00 00       	mov    0xa2c,%eax
 6ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6f5:	75 23                	jne    71a <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6f7:	c7 45 f0 24 0a 00 00 	movl   $0xa24,-0x10(%ebp)
 6fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
 701:	a3 2c 0a 00 00       	mov    %eax,0xa2c
 706:	a1 2c 0a 00 00       	mov    0xa2c,%eax
 70b:	a3 24 0a 00 00       	mov    %eax,0xa24
    base.s.size = 0;
 710:	c7 05 28 0a 00 00 00 	movl   $0x0,0xa28
 717:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71d:	8b 00                	mov    (%eax),%eax
 71f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 722:	8b 45 f4             	mov    -0xc(%ebp),%eax
 725:	8b 40 04             	mov    0x4(%eax),%eax
 728:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 72b:	72 4d                	jb     77a <malloc+0xa6>
      if(p->s.size == nunits)
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 736:	75 0c                	jne    744 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 738:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73b:	8b 10                	mov    (%eax),%edx
 73d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 740:	89 10                	mov    %edx,(%eax)
 742:	eb 26                	jmp    76a <malloc+0x96>
      else {
        p->s.size -= nunits;
 744:	8b 45 f4             	mov    -0xc(%ebp),%eax
 747:	8b 40 04             	mov    0x4(%eax),%eax
 74a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 74d:	89 c2                	mov    %eax,%edx
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8b 40 04             	mov    0x4(%eax),%eax
 75b:	c1 e0 03             	shl    $0x3,%eax
 75e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	8b 55 ec             	mov    -0x14(%ebp),%edx
 767:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 76a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76d:	a3 2c 0a 00 00       	mov    %eax,0xa2c
      return (void*)(p + 1);
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	83 c0 08             	add    $0x8,%eax
 778:	eb 3b                	jmp    7b5 <malloc+0xe1>
    }
    if(p == freep)
 77a:	a1 2c 0a 00 00       	mov    0xa2c,%eax
 77f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 782:	75 1e                	jne    7a2 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 784:	83 ec 0c             	sub    $0xc,%esp
 787:	ff 75 ec             	push   -0x14(%ebp)
 78a:	e8 e5 fe ff ff       	call   674 <morecore>
 78f:	83 c4 10             	add    $0x10,%esp
 792:	89 45 f4             	mov    %eax,-0xc(%ebp)
 795:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 799:	75 07                	jne    7a2 <malloc+0xce>
        return 0;
 79b:	b8 00 00 00 00       	mov    $0x0,%eax
 7a0:	eb 13                	jmp    7b5 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 00                	mov    (%eax),%eax
 7ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7b0:	e9 6d ff ff ff       	jmp    722 <malloc+0x4e>
  }
}
 7b5:	c9                   	leave
 7b6:	c3                   	ret
