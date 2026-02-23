
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:

// Execute cmd.  Never returns.
__attribute__((noreturn))
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 ab 0e 00 00       	call   ebc <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 1c 14 00 00 	mov    0x141c(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 f0 13 00 00       	push   $0x13f0
      2c:	e8 4f 03 00 00       	call   380 <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 73 0e 00 00       	call   ebc <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 95 0e 00 00       	call   ef4 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 f7 13 00 00       	push   $0x13f7
      71:	6a 02                	push   $0x2
      73:	e8 c0 0f 00 00       	call   1038 <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 aa 01 00 00       	jmp    22a <runcmd+0x22a>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 e8             	mov    %eax,-0x18(%ebp)
    close(rcmd->fd);
      86:	8b 45 e8             	mov    -0x18(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 4f 0e 00 00       	call   ee4 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 e8             	mov    -0x18(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 4e 0e 00 00       	call   efc <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 07 14 00 00       	push   $0x1407
      c4:	6a 02                	push   $0x2
      c6:	e8 6d 0f 00 00       	call   1038 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 e9 0d 00 00       	call   ebc <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
      e2:	8b 45 08             	mov    0x8(%ebp),%eax
      e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fork1() == 0)
      e8:	e8 b3 02 00 00       	call   3a0 <fork1>
      ed:	85 c0                	test   %eax,%eax
      ef:	75 0f                	jne    100 <runcmd+0x100>
      runcmd(lcmd->left);
      f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f4:	8b 40 04             	mov    0x4(%eax),%eax
      f7:	83 ec 0c             	sub    $0xc,%esp
      fa:	50                   	push   %eax
      fb:	e8 00 ff ff ff       	call   0 <runcmd>
    wait();
     100:	e8 bf 0d 00 00       	call   ec4 <wait>
    runcmd(lcmd->right);
     105:	8b 45 f0             	mov    -0x10(%ebp),%eax
     108:	8b 40 08             	mov    0x8(%eax),%eax
     10b:	83 ec 0c             	sub    $0xc,%esp
     10e:	50                   	push   %eax
     10f:	e8 ec fe ff ff       	call   0 <runcmd>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     114:	8b 45 08             	mov    0x8(%ebp),%eax
     117:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pipe(p) < 0)
     11a:	83 ec 0c             	sub    $0xc,%esp
     11d:	8d 45 dc             	lea    -0x24(%ebp),%eax
     120:	50                   	push   %eax
     121:	e8 a6 0d 00 00       	call   ecc <pipe>
     126:	83 c4 10             	add    $0x10,%esp
     129:	85 c0                	test   %eax,%eax
     12b:	79 10                	jns    13d <runcmd+0x13d>
      panic("pipe");
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	68 17 14 00 00       	push   $0x1417
     135:	e8 46 02 00 00       	call   380 <panic>
     13a:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     13d:	e8 5e 02 00 00       	call   3a0 <fork1>
     142:	85 c0                	test   %eax,%eax
     144:	75 49                	jne    18f <runcmd+0x18f>
      close(1);
     146:	83 ec 0c             	sub    $0xc,%esp
     149:	6a 01                	push   $0x1
     14b:	e8 94 0d 00 00       	call   ee4 <close>
     150:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     153:	8b 45 e0             	mov    -0x20(%ebp),%eax
     156:	83 ec 0c             	sub    $0xc,%esp
     159:	50                   	push   %eax
     15a:	e8 d5 0d 00 00       	call   f34 <dup>
     15f:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     162:	8b 45 dc             	mov    -0x24(%ebp),%eax
     165:	83 ec 0c             	sub    $0xc,%esp
     168:	50                   	push   %eax
     169:	e8 76 0d 00 00       	call   ee4 <close>
     16e:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     171:	8b 45 e0             	mov    -0x20(%ebp),%eax
     174:	83 ec 0c             	sub    $0xc,%esp
     177:	50                   	push   %eax
     178:	e8 67 0d 00 00       	call   ee4 <close>
     17d:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     180:	8b 45 ec             	mov    -0x14(%ebp),%eax
     183:	8b 40 04             	mov    0x4(%eax),%eax
     186:	83 ec 0c             	sub    $0xc,%esp
     189:	50                   	push   %eax
     18a:	e8 71 fe ff ff       	call   0 <runcmd>
    }
    if(fork1() == 0){
     18f:	e8 0c 02 00 00       	call   3a0 <fork1>
     194:	85 c0                	test   %eax,%eax
     196:	75 49                	jne    1e1 <runcmd+0x1e1>
      close(0);
     198:	83 ec 0c             	sub    $0xc,%esp
     19b:	6a 00                	push   $0x0
     19d:	e8 42 0d 00 00       	call   ee4 <close>
     1a2:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1a5:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1a8:	83 ec 0c             	sub    $0xc,%esp
     1ab:	50                   	push   %eax
     1ac:	e8 83 0d 00 00       	call   f34 <dup>
     1b1:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1b7:	83 ec 0c             	sub    $0xc,%esp
     1ba:	50                   	push   %eax
     1bb:	e8 24 0d 00 00       	call   ee4 <close>
     1c0:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1c6:	83 ec 0c             	sub    $0xc,%esp
     1c9:	50                   	push   %eax
     1ca:	e8 15 0d 00 00       	call   ee4 <close>
     1cf:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1d5:	8b 40 08             	mov    0x8(%eax),%eax
     1d8:	83 ec 0c             	sub    $0xc,%esp
     1db:	50                   	push   %eax
     1dc:	e8 1f fe ff ff       	call   0 <runcmd>
    }
    close(p[0]);
     1e1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1e4:	83 ec 0c             	sub    $0xc,%esp
     1e7:	50                   	push   %eax
     1e8:	e8 f7 0c 00 00       	call   ee4 <close>
     1ed:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1f3:	83 ec 0c             	sub    $0xc,%esp
     1f6:	50                   	push   %eax
     1f7:	e8 e8 0c 00 00       	call   ee4 <close>
     1fc:	83 c4 10             	add    $0x10,%esp
    wait();
     1ff:	e8 c0 0c 00 00       	call   ec4 <wait>
    wait();
     204:	e8 bb 0c 00 00       	call   ec4 <wait>
    break;
     209:	eb 1f                	jmp    22a <runcmd+0x22a>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     20b:	8b 45 08             	mov    0x8(%ebp),%eax
     20e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     211:	e8 8a 01 00 00       	call   3a0 <fork1>
     216:	85 c0                	test   %eax,%eax
     218:	75 0f                	jne    229 <runcmd+0x229>
      runcmd(bcmd->cmd);
     21a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     21d:	8b 40 04             	mov    0x4(%eax),%eax
     220:	83 ec 0c             	sub    $0xc,%esp
     223:	50                   	push   %eax
     224:	e8 d7 fd ff ff       	call   0 <runcmd>
    break;
     229:	90                   	nop
  }
  exit();
     22a:	e8 8d 0c 00 00       	call   ebc <exit>

0000022f <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     22f:	55                   	push   %ebp
     230:	89 e5                	mov    %esp,%ebp
     232:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     235:	83 ec 08             	sub    $0x8,%esp
     238:	68 34 14 00 00       	push   $0x1434
     23d:	6a 02                	push   $0x2
     23f:	e8 f4 0d 00 00       	call   1038 <printf>
     244:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     247:	8b 45 0c             	mov    0xc(%ebp),%eax
     24a:	83 ec 04             	sub    $0x4,%esp
     24d:	50                   	push   %eax
     24e:	6a 00                	push   $0x0
     250:	ff 75 08             	push   0x8(%ebp)
     253:	e8 c9 0a 00 00       	call   d21 <memset>
     258:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     25b:	83 ec 08             	sub    $0x8,%esp
     25e:	ff 75 0c             	push   0xc(%ebp)
     261:	ff 75 08             	push   0x8(%ebp)
     264:	e8 05 0b 00 00       	call   d6e <gets>
     269:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     26c:	8b 45 08             	mov    0x8(%ebp),%eax
     26f:	0f b6 00             	movzbl (%eax),%eax
     272:	84 c0                	test   %al,%al
     274:	75 07                	jne    27d <getcmd+0x4e>
    return -1;
     276:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     27b:	eb 05                	jmp    282 <getcmd+0x53>
  return 0;
     27d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     282:	c9                   	leave
     283:	c3                   	ret

00000284 <main>:

int
main(void)
{
     284:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     288:	83 e4 f0             	and    $0xfffffff0,%esp
     28b:	ff 71 fc             	push   -0x4(%ecx)
     28e:	55                   	push   %ebp
     28f:	89 e5                	mov    %esp,%ebp
     291:	51                   	push   %ecx
     292:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     295:	eb 16                	jmp    2ad <main+0x29>
    if(fd >= 3){
     297:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     29b:	7e 10                	jle    2ad <main+0x29>
      close(fd);
     29d:	83 ec 0c             	sub    $0xc,%esp
     2a0:	ff 75 f4             	push   -0xc(%ebp)
     2a3:	e8 3c 0c 00 00       	call   ee4 <close>
     2a8:	83 c4 10             	add    $0x10,%esp
      break;
     2ab:	eb 1b                	jmp    2c8 <main+0x44>
  while((fd = open("console", O_RDWR)) >= 0){
     2ad:	83 ec 08             	sub    $0x8,%esp
     2b0:	6a 02                	push   $0x2
     2b2:	68 37 14 00 00       	push   $0x1437
     2b7:	e8 40 0c 00 00       	call   efc <open>
     2bc:	83 c4 10             	add    $0x10,%esp
     2bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2c6:	79 cf                	jns    297 <main+0x13>
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2c8:	e9 94 00 00 00       	jmp    361 <main+0xdd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2cd:	0f b6 05 a0 19 00 00 	movzbl 0x19a0,%eax
     2d4:	3c 63                	cmp    $0x63,%al
     2d6:	75 5f                	jne    337 <main+0xb3>
     2d8:	0f b6 05 a1 19 00 00 	movzbl 0x19a1,%eax
     2df:	3c 64                	cmp    $0x64,%al
     2e1:	75 54                	jne    337 <main+0xb3>
     2e3:	0f b6 05 a2 19 00 00 	movzbl 0x19a2,%eax
     2ea:	3c 20                	cmp    $0x20,%al
     2ec:	75 49                	jne    337 <main+0xb3>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     2ee:	83 ec 0c             	sub    $0xc,%esp
     2f1:	68 a0 19 00 00       	push   $0x19a0
     2f6:	e8 ff 09 00 00       	call   cfa <strlen>
     2fb:	83 c4 10             	add    $0x10,%esp
     2fe:	83 e8 01             	sub    $0x1,%eax
     301:	c6 80 a0 19 00 00 00 	movb   $0x0,0x19a0(%eax)
      if(chdir(buf+3) < 0)
     308:	b8 a3 19 00 00       	mov    $0x19a3,%eax
     30d:	83 ec 0c             	sub    $0xc,%esp
     310:	50                   	push   %eax
     311:	e8 16 0c 00 00       	call   f2c <chdir>
     316:	83 c4 10             	add    $0x10,%esp
     319:	85 c0                	test   %eax,%eax
     31b:	79 43                	jns    360 <main+0xdc>
        printf(2, "cannot cd %s\n", buf+3);
     31d:	b8 a3 19 00 00       	mov    $0x19a3,%eax
     322:	83 ec 04             	sub    $0x4,%esp
     325:	50                   	push   %eax
     326:	68 3f 14 00 00       	push   $0x143f
     32b:	6a 02                	push   $0x2
     32d:	e8 06 0d 00 00       	call   1038 <printf>
     332:	83 c4 10             	add    $0x10,%esp
      continue;
     335:	eb 29                	jmp    360 <main+0xdc>
    }
    if(fork1() == 0)
     337:	e8 64 00 00 00       	call   3a0 <fork1>
     33c:	85 c0                	test   %eax,%eax
     33e:	75 19                	jne    359 <main+0xd5>
      runcmd(parsecmd(buf));
     340:	83 ec 0c             	sub    $0xc,%esp
     343:	68 a0 19 00 00       	push   $0x19a0
     348:	e8 aa 03 00 00       	call   6f7 <parsecmd>
     34d:	83 c4 10             	add    $0x10,%esp
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	50                   	push   %eax
     354:	e8 a7 fc ff ff       	call   0 <runcmd>
    wait();
     359:	e8 66 0b 00 00       	call   ec4 <wait>
     35e:	eb 01                	jmp    361 <main+0xdd>
      continue;
     360:	90                   	nop
  while(getcmd(buf, sizeof(buf)) >= 0){
     361:	83 ec 08             	sub    $0x8,%esp
     364:	6a 64                	push   $0x64
     366:	68 a0 19 00 00       	push   $0x19a0
     36b:	e8 bf fe ff ff       	call   22f <getcmd>
     370:	83 c4 10             	add    $0x10,%esp
     373:	85 c0                	test   %eax,%eax
     375:	0f 89 52 ff ff ff    	jns    2cd <main+0x49>
  }
  exit();
     37b:	e8 3c 0b 00 00       	call   ebc <exit>

00000380 <panic>:
}

void
panic(char *s)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     386:	83 ec 04             	sub    $0x4,%esp
     389:	ff 75 08             	push   0x8(%ebp)
     38c:	68 4d 14 00 00       	push   $0x144d
     391:	6a 02                	push   $0x2
     393:	e8 a0 0c 00 00       	call   1038 <printf>
     398:	83 c4 10             	add    $0x10,%esp
  exit();
     39b:	e8 1c 0b 00 00       	call   ebc <exit>

000003a0 <fork1>:
}

int
fork1(void)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     3a6:	e8 09 0b 00 00       	call   eb4 <fork>
     3ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3ae:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3b2:	75 10                	jne    3c4 <fork1+0x24>
    panic("fork");
     3b4:	83 ec 0c             	sub    $0xc,%esp
     3b7:	68 51 14 00 00       	push   $0x1451
     3bc:	e8 bf ff ff ff       	call   380 <panic>
     3c1:	83 c4 10             	add    $0x10,%esp
  return pid;
     3c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3c7:	c9                   	leave
     3c8:	c3                   	ret

000003c9 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3c9:	55                   	push   %ebp
     3ca:	89 e5                	mov    %esp,%ebp
     3cc:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3cf:	83 ec 0c             	sub    $0xc,%esp
     3d2:	6a 54                	push   $0x54
     3d4:	e8 33 0f 00 00       	call   130c <malloc>
     3d9:	83 c4 10             	add    $0x10,%esp
     3dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3df:	83 ec 04             	sub    $0x4,%esp
     3e2:	6a 54                	push   $0x54
     3e4:	6a 00                	push   $0x0
     3e6:	ff 75 f4             	push   -0xc(%ebp)
     3e9:	e8 33 09 00 00       	call   d21 <memset>
     3ee:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     3f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3f4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     3fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3fd:	c9                   	leave
     3fe:	c3                   	ret

000003ff <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3ff:	55                   	push   %ebp
     400:	89 e5                	mov    %esp,%ebp
     402:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     405:	83 ec 0c             	sub    $0xc,%esp
     408:	6a 18                	push   $0x18
     40a:	e8 fd 0e 00 00       	call   130c <malloc>
     40f:	83 c4 10             	add    $0x10,%esp
     412:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     415:	83 ec 04             	sub    $0x4,%esp
     418:	6a 18                	push   $0x18
     41a:	6a 00                	push   $0x0
     41c:	ff 75 f4             	push   -0xc(%ebp)
     41f:	e8 fd 08 00 00       	call   d21 <memset>
     424:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     427:	8b 45 f4             	mov    -0xc(%ebp),%eax
     42a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     430:	8b 45 f4             	mov    -0xc(%ebp),%eax
     433:	8b 55 08             	mov    0x8(%ebp),%edx
     436:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     439:	8b 45 f4             	mov    -0xc(%ebp),%eax
     43c:	8b 55 0c             	mov    0xc(%ebp),%edx
     43f:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     442:	8b 45 f4             	mov    -0xc(%ebp),%eax
     445:	8b 55 10             	mov    0x10(%ebp),%edx
     448:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     44b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44e:	8b 55 14             	mov    0x14(%ebp),%edx
     451:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     454:	8b 45 f4             	mov    -0xc(%ebp),%eax
     457:	8b 55 18             	mov    0x18(%ebp),%edx
     45a:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     45d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     460:	c9                   	leave
     461:	c3                   	ret

00000462 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     462:	55                   	push   %ebp
     463:	89 e5                	mov    %esp,%ebp
     465:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     468:	83 ec 0c             	sub    $0xc,%esp
     46b:	6a 0c                	push   $0xc
     46d:	e8 9a 0e 00 00       	call   130c <malloc>
     472:	83 c4 10             	add    $0x10,%esp
     475:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     478:	83 ec 04             	sub    $0x4,%esp
     47b:	6a 0c                	push   $0xc
     47d:	6a 00                	push   $0x0
     47f:	ff 75 f4             	push   -0xc(%ebp)
     482:	e8 9a 08 00 00       	call   d21 <memset>
     487:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     48a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     48d:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     493:	8b 45 f4             	mov    -0xc(%ebp),%eax
     496:	8b 55 08             	mov    0x8(%ebp),%edx
     499:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     49c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     49f:	8b 55 0c             	mov    0xc(%ebp),%edx
     4a2:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4a8:	c9                   	leave
     4a9:	c3                   	ret

000004aa <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4aa:	55                   	push   %ebp
     4ab:	89 e5                	mov    %esp,%ebp
     4ad:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4b0:	83 ec 0c             	sub    $0xc,%esp
     4b3:	6a 0c                	push   $0xc
     4b5:	e8 52 0e 00 00       	call   130c <malloc>
     4ba:	83 c4 10             	add    $0x10,%esp
     4bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4c0:	83 ec 04             	sub    $0x4,%esp
     4c3:	6a 0c                	push   $0xc
     4c5:	6a 00                	push   $0x0
     4c7:	ff 75 f4             	push   -0xc(%ebp)
     4ca:	e8 52 08 00 00       	call   d21 <memset>
     4cf:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d5:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4de:	8b 55 08             	mov    0x8(%ebp),%edx
     4e1:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e7:	8b 55 0c             	mov    0xc(%ebp),%edx
     4ea:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4f0:	c9                   	leave
     4f1:	c3                   	ret

000004f2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4f2:	55                   	push   %ebp
     4f3:	89 e5                	mov    %esp,%ebp
     4f5:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4f8:	83 ec 0c             	sub    $0xc,%esp
     4fb:	6a 08                	push   $0x8
     4fd:	e8 0a 0e 00 00       	call   130c <malloc>
     502:	83 c4 10             	add    $0x10,%esp
     505:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     508:	83 ec 04             	sub    $0x4,%esp
     50b:	6a 08                	push   $0x8
     50d:	6a 00                	push   $0x0
     50f:	ff 75 f4             	push   -0xc(%ebp)
     512:	e8 0a 08 00 00       	call   d21 <memset>
     517:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     51a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     51d:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     523:	8b 45 f4             	mov    -0xc(%ebp),%eax
     526:	8b 55 08             	mov    0x8(%ebp),%edx
     529:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     52c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     52f:	c9                   	leave
     530:	c3                   	ret

00000531 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     531:	55                   	push   %ebp
     532:	89 e5                	mov    %esp,%ebp
     534:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     537:	8b 45 08             	mov    0x8(%ebp),%eax
     53a:	8b 00                	mov    (%eax),%eax
     53c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     53f:	eb 04                	jmp    545 <gettoken+0x14>
    s++;
     541:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     545:	8b 45 f4             	mov    -0xc(%ebp),%eax
     548:	3b 45 0c             	cmp    0xc(%ebp),%eax
     54b:	73 1e                	jae    56b <gettoken+0x3a>
     54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     550:	0f b6 00             	movzbl (%eax),%eax
     553:	0f be c0             	movsbl %al,%eax
     556:	83 ec 08             	sub    $0x8,%esp
     559:	50                   	push   %eax
     55a:	68 68 19 00 00       	push   $0x1968
     55f:	e8 d7 07 00 00       	call   d3b <strchr>
     564:	83 c4 10             	add    $0x10,%esp
     567:	85 c0                	test   %eax,%eax
     569:	75 d6                	jne    541 <gettoken+0x10>
  if(q)
     56b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     56f:	74 08                	je     579 <gettoken+0x48>
    *q = s;
     571:	8b 45 10             	mov    0x10(%ebp),%eax
     574:	8b 55 f4             	mov    -0xc(%ebp),%edx
     577:	89 10                	mov    %edx,(%eax)
  ret = *s;
     579:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57c:	0f b6 00             	movzbl (%eax),%eax
     57f:	0f be c0             	movsbl %al,%eax
     582:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     585:	8b 45 f4             	mov    -0xc(%ebp),%eax
     588:	0f b6 00             	movzbl (%eax),%eax
     58b:	0f be c0             	movsbl %al,%eax
     58e:	83 f8 7c             	cmp    $0x7c,%eax
     591:	74 2c                	je     5bf <gettoken+0x8e>
     593:	83 f8 7c             	cmp    $0x7c,%eax
     596:	7f 48                	jg     5e0 <gettoken+0xaf>
     598:	83 f8 3e             	cmp    $0x3e,%eax
     59b:	74 28                	je     5c5 <gettoken+0x94>
     59d:	83 f8 3e             	cmp    $0x3e,%eax
     5a0:	7f 3e                	jg     5e0 <gettoken+0xaf>
     5a2:	83 f8 3c             	cmp    $0x3c,%eax
     5a5:	7f 39                	jg     5e0 <gettoken+0xaf>
     5a7:	83 f8 3b             	cmp    $0x3b,%eax
     5aa:	7d 13                	jge    5bf <gettoken+0x8e>
     5ac:	83 f8 29             	cmp    $0x29,%eax
     5af:	7f 2f                	jg     5e0 <gettoken+0xaf>
     5b1:	83 f8 28             	cmp    $0x28,%eax
     5b4:	7d 09                	jge    5bf <gettoken+0x8e>
     5b6:	85 c0                	test   %eax,%eax
     5b8:	74 79                	je     633 <gettoken+0x102>
     5ba:	83 f8 26             	cmp    $0x26,%eax
     5bd:	75 21                	jne    5e0 <gettoken+0xaf>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5c3:	eb 75                	jmp    63a <gettoken+0x109>
  case '>':
    s++;
     5c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5cc:	0f b6 00             	movzbl (%eax),%eax
     5cf:	3c 3e                	cmp    $0x3e,%al
     5d1:	75 63                	jne    636 <gettoken+0x105>
      ret = '+';
     5d3:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5da:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     5de:	eb 56                	jmp    636 <gettoken+0x105>
  default:
    ret = 'a';
     5e0:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5e7:	eb 04                	jmp    5ed <gettoken+0xbc>
      s++;
     5e9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
     5f3:	73 44                	jae    639 <gettoken+0x108>
     5f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f8:	0f b6 00             	movzbl (%eax),%eax
     5fb:	0f be c0             	movsbl %al,%eax
     5fe:	83 ec 08             	sub    $0x8,%esp
     601:	50                   	push   %eax
     602:	68 68 19 00 00       	push   $0x1968
     607:	e8 2f 07 00 00       	call   d3b <strchr>
     60c:	83 c4 10             	add    $0x10,%esp
     60f:	85 c0                	test   %eax,%eax
     611:	75 26                	jne    639 <gettoken+0x108>
     613:	8b 45 f4             	mov    -0xc(%ebp),%eax
     616:	0f b6 00             	movzbl (%eax),%eax
     619:	0f be c0             	movsbl %al,%eax
     61c:	83 ec 08             	sub    $0x8,%esp
     61f:	50                   	push   %eax
     620:	68 70 19 00 00       	push   $0x1970
     625:	e8 11 07 00 00       	call   d3b <strchr>
     62a:	83 c4 10             	add    $0x10,%esp
     62d:	85 c0                	test   %eax,%eax
     62f:	74 b8                	je     5e9 <gettoken+0xb8>
    break;
     631:	eb 06                	jmp    639 <gettoken+0x108>
    break;
     633:	90                   	nop
     634:	eb 04                	jmp    63a <gettoken+0x109>
    break;
     636:	90                   	nop
     637:	eb 01                	jmp    63a <gettoken+0x109>
    break;
     639:	90                   	nop
  }
  if(eq)
     63a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     63e:	74 0e                	je     64e <gettoken+0x11d>
    *eq = s;
     640:	8b 45 14             	mov    0x14(%ebp),%eax
     643:	8b 55 f4             	mov    -0xc(%ebp),%edx
     646:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     648:	eb 04                	jmp    64e <gettoken+0x11d>
    s++;
     64a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     64e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     651:	3b 45 0c             	cmp    0xc(%ebp),%eax
     654:	73 1e                	jae    674 <gettoken+0x143>
     656:	8b 45 f4             	mov    -0xc(%ebp),%eax
     659:	0f b6 00             	movzbl (%eax),%eax
     65c:	0f be c0             	movsbl %al,%eax
     65f:	83 ec 08             	sub    $0x8,%esp
     662:	50                   	push   %eax
     663:	68 68 19 00 00       	push   $0x1968
     668:	e8 ce 06 00 00       	call   d3b <strchr>
     66d:	83 c4 10             	add    $0x10,%esp
     670:	85 c0                	test   %eax,%eax
     672:	75 d6                	jne    64a <gettoken+0x119>
  *ps = s;
     674:	8b 45 08             	mov    0x8(%ebp),%eax
     677:	8b 55 f4             	mov    -0xc(%ebp),%edx
     67a:	89 10                	mov    %edx,(%eax)
  return ret;
     67c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     67f:	c9                   	leave
     680:	c3                   	ret

00000681 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     681:	55                   	push   %ebp
     682:	89 e5                	mov    %esp,%ebp
     684:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     687:	8b 45 08             	mov    0x8(%ebp),%eax
     68a:	8b 00                	mov    (%eax),%eax
     68c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     68f:	eb 04                	jmp    695 <peek+0x14>
    s++;
     691:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     695:	8b 45 f4             	mov    -0xc(%ebp),%eax
     698:	3b 45 0c             	cmp    0xc(%ebp),%eax
     69b:	73 1e                	jae    6bb <peek+0x3a>
     69d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a0:	0f b6 00             	movzbl (%eax),%eax
     6a3:	0f be c0             	movsbl %al,%eax
     6a6:	83 ec 08             	sub    $0x8,%esp
     6a9:	50                   	push   %eax
     6aa:	68 68 19 00 00       	push   $0x1968
     6af:	e8 87 06 00 00       	call   d3b <strchr>
     6b4:	83 c4 10             	add    $0x10,%esp
     6b7:	85 c0                	test   %eax,%eax
     6b9:	75 d6                	jne    691 <peek+0x10>
  *ps = s;
     6bb:	8b 45 08             	mov    0x8(%ebp),%eax
     6be:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6c1:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c6:	0f b6 00             	movzbl (%eax),%eax
     6c9:	84 c0                	test   %al,%al
     6cb:	74 23                	je     6f0 <peek+0x6f>
     6cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d0:	0f b6 00             	movzbl (%eax),%eax
     6d3:	0f be c0             	movsbl %al,%eax
     6d6:	83 ec 08             	sub    $0x8,%esp
     6d9:	50                   	push   %eax
     6da:	ff 75 10             	push   0x10(%ebp)
     6dd:	e8 59 06 00 00       	call   d3b <strchr>
     6e2:	83 c4 10             	add    $0x10,%esp
     6e5:	85 c0                	test   %eax,%eax
     6e7:	74 07                	je     6f0 <peek+0x6f>
     6e9:	b8 01 00 00 00       	mov    $0x1,%eax
     6ee:	eb 05                	jmp    6f5 <peek+0x74>
     6f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
     6f5:	c9                   	leave
     6f6:	c3                   	ret

000006f7 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     6f7:	55                   	push   %ebp
     6f8:	89 e5                	mov    %esp,%ebp
     6fa:	53                   	push   %ebx
     6fb:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     6fe:	8b 5d 08             	mov    0x8(%ebp),%ebx
     701:	8b 45 08             	mov    0x8(%ebp),%eax
     704:	83 ec 0c             	sub    $0xc,%esp
     707:	50                   	push   %eax
     708:	e8 ed 05 00 00       	call   cfa <strlen>
     70d:	83 c4 10             	add    $0x10,%esp
     710:	01 d8                	add    %ebx,%eax
     712:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     715:	83 ec 08             	sub    $0x8,%esp
     718:	ff 75 f4             	push   -0xc(%ebp)
     71b:	8d 45 08             	lea    0x8(%ebp),%eax
     71e:	50                   	push   %eax
     71f:	e8 61 00 00 00       	call   785 <parseline>
     724:	83 c4 10             	add    $0x10,%esp
     727:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     72a:	83 ec 04             	sub    $0x4,%esp
     72d:	68 56 14 00 00       	push   $0x1456
     732:	ff 75 f4             	push   -0xc(%ebp)
     735:	8d 45 08             	lea    0x8(%ebp),%eax
     738:	50                   	push   %eax
     739:	e8 43 ff ff ff       	call   681 <peek>
     73e:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     741:	8b 45 08             	mov    0x8(%ebp),%eax
     744:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     747:	74 26                	je     76f <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     749:	8b 45 08             	mov    0x8(%ebp),%eax
     74c:	83 ec 04             	sub    $0x4,%esp
     74f:	50                   	push   %eax
     750:	68 57 14 00 00       	push   $0x1457
     755:	6a 02                	push   $0x2
     757:	e8 dc 08 00 00       	call   1038 <printf>
     75c:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     75f:	83 ec 0c             	sub    $0xc,%esp
     762:	68 66 14 00 00       	push   $0x1466
     767:	e8 14 fc ff ff       	call   380 <panic>
     76c:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     76f:	83 ec 0c             	sub    $0xc,%esp
     772:	ff 75 f0             	push   -0x10(%ebp)
     775:	e8 ef 03 00 00       	call   b69 <nulterminate>
     77a:	83 c4 10             	add    $0x10,%esp
  return cmd;
     77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     780:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     783:	c9                   	leave
     784:	c3                   	ret

00000785 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     785:	55                   	push   %ebp
     786:	89 e5                	mov    %esp,%ebp
     788:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     78b:	83 ec 08             	sub    $0x8,%esp
     78e:	ff 75 0c             	push   0xc(%ebp)
     791:	ff 75 08             	push   0x8(%ebp)
     794:	e8 99 00 00 00       	call   832 <parsepipe>
     799:	83 c4 10             	add    $0x10,%esp
     79c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     79f:	eb 23                	jmp    7c4 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7a1:	6a 00                	push   $0x0
     7a3:	6a 00                	push   $0x0
     7a5:	ff 75 0c             	push   0xc(%ebp)
     7a8:	ff 75 08             	push   0x8(%ebp)
     7ab:	e8 81 fd ff ff       	call   531 <gettoken>
     7b0:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7b3:	83 ec 0c             	sub    $0xc,%esp
     7b6:	ff 75 f4             	push   -0xc(%ebp)
     7b9:	e8 34 fd ff ff       	call   4f2 <backcmd>
     7be:	83 c4 10             	add    $0x10,%esp
     7c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7c4:	83 ec 04             	sub    $0x4,%esp
     7c7:	68 6d 14 00 00       	push   $0x146d
     7cc:	ff 75 0c             	push   0xc(%ebp)
     7cf:	ff 75 08             	push   0x8(%ebp)
     7d2:	e8 aa fe ff ff       	call   681 <peek>
     7d7:	83 c4 10             	add    $0x10,%esp
     7da:	85 c0                	test   %eax,%eax
     7dc:	75 c3                	jne    7a1 <parseline+0x1c>
  }
  if(peek(ps, es, ";")){
     7de:	83 ec 04             	sub    $0x4,%esp
     7e1:	68 6f 14 00 00       	push   $0x146f
     7e6:	ff 75 0c             	push   0xc(%ebp)
     7e9:	ff 75 08             	push   0x8(%ebp)
     7ec:	e8 90 fe ff ff       	call   681 <peek>
     7f1:	83 c4 10             	add    $0x10,%esp
     7f4:	85 c0                	test   %eax,%eax
     7f6:	74 35                	je     82d <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     7f8:	6a 00                	push   $0x0
     7fa:	6a 00                	push   $0x0
     7fc:	ff 75 0c             	push   0xc(%ebp)
     7ff:	ff 75 08             	push   0x8(%ebp)
     802:	e8 2a fd ff ff       	call   531 <gettoken>
     807:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     80a:	83 ec 08             	sub    $0x8,%esp
     80d:	ff 75 0c             	push   0xc(%ebp)
     810:	ff 75 08             	push   0x8(%ebp)
     813:	e8 6d ff ff ff       	call   785 <parseline>
     818:	83 c4 10             	add    $0x10,%esp
     81b:	83 ec 08             	sub    $0x8,%esp
     81e:	50                   	push   %eax
     81f:	ff 75 f4             	push   -0xc(%ebp)
     822:	e8 83 fc ff ff       	call   4aa <listcmd>
     827:	83 c4 10             	add    $0x10,%esp
     82a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     830:	c9                   	leave
     831:	c3                   	ret

00000832 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     832:	55                   	push   %ebp
     833:	89 e5                	mov    %esp,%ebp
     835:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     838:	83 ec 08             	sub    $0x8,%esp
     83b:	ff 75 0c             	push   0xc(%ebp)
     83e:	ff 75 08             	push   0x8(%ebp)
     841:	e8 f0 01 00 00       	call   a36 <parseexec>
     846:	83 c4 10             	add    $0x10,%esp
     849:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     84c:	83 ec 04             	sub    $0x4,%esp
     84f:	68 71 14 00 00       	push   $0x1471
     854:	ff 75 0c             	push   0xc(%ebp)
     857:	ff 75 08             	push   0x8(%ebp)
     85a:	e8 22 fe ff ff       	call   681 <peek>
     85f:	83 c4 10             	add    $0x10,%esp
     862:	85 c0                	test   %eax,%eax
     864:	74 35                	je     89b <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     866:	6a 00                	push   $0x0
     868:	6a 00                	push   $0x0
     86a:	ff 75 0c             	push   0xc(%ebp)
     86d:	ff 75 08             	push   0x8(%ebp)
     870:	e8 bc fc ff ff       	call   531 <gettoken>
     875:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     878:	83 ec 08             	sub    $0x8,%esp
     87b:	ff 75 0c             	push   0xc(%ebp)
     87e:	ff 75 08             	push   0x8(%ebp)
     881:	e8 ac ff ff ff       	call   832 <parsepipe>
     886:	83 c4 10             	add    $0x10,%esp
     889:	83 ec 08             	sub    $0x8,%esp
     88c:	50                   	push   %eax
     88d:	ff 75 f4             	push   -0xc(%ebp)
     890:	e8 cd fb ff ff       	call   462 <pipecmd>
     895:	83 c4 10             	add    $0x10,%esp
     898:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     89b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     89e:	c9                   	leave
     89f:	c3                   	ret

000008a0 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8a6:	e9 ba 00 00 00       	jmp    965 <parseredirs+0xc5>
    tok = gettoken(ps, es, 0, 0);
     8ab:	6a 00                	push   $0x0
     8ad:	6a 00                	push   $0x0
     8af:	ff 75 10             	push   0x10(%ebp)
     8b2:	ff 75 0c             	push   0xc(%ebp)
     8b5:	e8 77 fc ff ff       	call   531 <gettoken>
     8ba:	83 c4 10             	add    $0x10,%esp
     8bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8c0:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8c3:	50                   	push   %eax
     8c4:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8c7:	50                   	push   %eax
     8c8:	ff 75 10             	push   0x10(%ebp)
     8cb:	ff 75 0c             	push   0xc(%ebp)
     8ce:	e8 5e fc ff ff       	call   531 <gettoken>
     8d3:	83 c4 10             	add    $0x10,%esp
     8d6:	83 f8 61             	cmp    $0x61,%eax
     8d9:	74 10                	je     8eb <parseredirs+0x4b>
      panic("missing file for redirection");
     8db:	83 ec 0c             	sub    $0xc,%esp
     8de:	68 73 14 00 00       	push   $0x1473
     8e3:	e8 98 fa ff ff       	call   380 <panic>
     8e8:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     8eb:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     8ef:	74 31                	je     922 <parseredirs+0x82>
     8f1:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     8f5:	7f 6e                	jg     965 <parseredirs+0xc5>
     8f7:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
     8fb:	74 47                	je     944 <parseredirs+0xa4>
     8fd:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
     901:	75 62                	jne    965 <parseredirs+0xc5>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     903:	8b 55 ec             	mov    -0x14(%ebp),%edx
     906:	8b 45 f0             	mov    -0x10(%ebp),%eax
     909:	83 ec 0c             	sub    $0xc,%esp
     90c:	6a 00                	push   $0x0
     90e:	6a 00                	push   $0x0
     910:	52                   	push   %edx
     911:	50                   	push   %eax
     912:	ff 75 08             	push   0x8(%ebp)
     915:	e8 e5 fa ff ff       	call   3ff <redircmd>
     91a:	83 c4 20             	add    $0x20,%esp
     91d:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     920:	eb 43                	jmp    965 <parseredirs+0xc5>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     922:	8b 55 ec             	mov    -0x14(%ebp),%edx
     925:	8b 45 f0             	mov    -0x10(%ebp),%eax
     928:	83 ec 0c             	sub    $0xc,%esp
     92b:	6a 01                	push   $0x1
     92d:	68 01 02 00 00       	push   $0x201
     932:	52                   	push   %edx
     933:	50                   	push   %eax
     934:	ff 75 08             	push   0x8(%ebp)
     937:	e8 c3 fa ff ff       	call   3ff <redircmd>
     93c:	83 c4 20             	add    $0x20,%esp
     93f:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     942:	eb 21                	jmp    965 <parseredirs+0xc5>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     944:	8b 55 ec             	mov    -0x14(%ebp),%edx
     947:	8b 45 f0             	mov    -0x10(%ebp),%eax
     94a:	83 ec 0c             	sub    $0xc,%esp
     94d:	6a 01                	push   $0x1
     94f:	68 01 02 00 00       	push   $0x201
     954:	52                   	push   %edx
     955:	50                   	push   %eax
     956:	ff 75 08             	push   0x8(%ebp)
     959:	e8 a1 fa ff ff       	call   3ff <redircmd>
     95e:	83 c4 20             	add    $0x20,%esp
     961:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     964:	90                   	nop
  while(peek(ps, es, "<>")){
     965:	83 ec 04             	sub    $0x4,%esp
     968:	68 90 14 00 00       	push   $0x1490
     96d:	ff 75 10             	push   0x10(%ebp)
     970:	ff 75 0c             	push   0xc(%ebp)
     973:	e8 09 fd ff ff       	call   681 <peek>
     978:	83 c4 10             	add    $0x10,%esp
     97b:	85 c0                	test   %eax,%eax
     97d:	0f 85 28 ff ff ff    	jne    8ab <parseredirs+0xb>
    }
  }
  return cmd;
     983:	8b 45 08             	mov    0x8(%ebp),%eax
}
     986:	c9                   	leave
     987:	c3                   	ret

00000988 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     988:	55                   	push   %ebp
     989:	89 e5                	mov    %esp,%ebp
     98b:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     98e:	83 ec 04             	sub    $0x4,%esp
     991:	68 93 14 00 00       	push   $0x1493
     996:	ff 75 0c             	push   0xc(%ebp)
     999:	ff 75 08             	push   0x8(%ebp)
     99c:	e8 e0 fc ff ff       	call   681 <peek>
     9a1:	83 c4 10             	add    $0x10,%esp
     9a4:	85 c0                	test   %eax,%eax
     9a6:	75 10                	jne    9b8 <parseblock+0x30>
    panic("parseblock");
     9a8:	83 ec 0c             	sub    $0xc,%esp
     9ab:	68 95 14 00 00       	push   $0x1495
     9b0:	e8 cb f9 ff ff       	call   380 <panic>
     9b5:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9b8:	6a 00                	push   $0x0
     9ba:	6a 00                	push   $0x0
     9bc:	ff 75 0c             	push   0xc(%ebp)
     9bf:	ff 75 08             	push   0x8(%ebp)
     9c2:	e8 6a fb ff ff       	call   531 <gettoken>
     9c7:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9ca:	83 ec 08             	sub    $0x8,%esp
     9cd:	ff 75 0c             	push   0xc(%ebp)
     9d0:	ff 75 08             	push   0x8(%ebp)
     9d3:	e8 ad fd ff ff       	call   785 <parseline>
     9d8:	83 c4 10             	add    $0x10,%esp
     9db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9de:	83 ec 04             	sub    $0x4,%esp
     9e1:	68 a0 14 00 00       	push   $0x14a0
     9e6:	ff 75 0c             	push   0xc(%ebp)
     9e9:	ff 75 08             	push   0x8(%ebp)
     9ec:	e8 90 fc ff ff       	call   681 <peek>
     9f1:	83 c4 10             	add    $0x10,%esp
     9f4:	85 c0                	test   %eax,%eax
     9f6:	75 10                	jne    a08 <parseblock+0x80>
    panic("syntax - missing )");
     9f8:	83 ec 0c             	sub    $0xc,%esp
     9fb:	68 a2 14 00 00       	push   $0x14a2
     a00:	e8 7b f9 ff ff       	call   380 <panic>
     a05:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a08:	6a 00                	push   $0x0
     a0a:	6a 00                	push   $0x0
     a0c:	ff 75 0c             	push   0xc(%ebp)
     a0f:	ff 75 08             	push   0x8(%ebp)
     a12:	e8 1a fb ff ff       	call   531 <gettoken>
     a17:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a1a:	83 ec 04             	sub    $0x4,%esp
     a1d:	ff 75 0c             	push   0xc(%ebp)
     a20:	ff 75 08             	push   0x8(%ebp)
     a23:	ff 75 f4             	push   -0xc(%ebp)
     a26:	e8 75 fe ff ff       	call   8a0 <parseredirs>
     a2b:	83 c4 10             	add    $0x10,%esp
     a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a34:	c9                   	leave
     a35:	c3                   	ret

00000a36 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a36:	55                   	push   %ebp
     a37:	89 e5                	mov    %esp,%ebp
     a39:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     a3c:	83 ec 04             	sub    $0x4,%esp
     a3f:	68 93 14 00 00       	push   $0x1493
     a44:	ff 75 0c             	push   0xc(%ebp)
     a47:	ff 75 08             	push   0x8(%ebp)
     a4a:	e8 32 fc ff ff       	call   681 <peek>
     a4f:	83 c4 10             	add    $0x10,%esp
     a52:	85 c0                	test   %eax,%eax
     a54:	74 16                	je     a6c <parseexec+0x36>
    return parseblock(ps, es);
     a56:	83 ec 08             	sub    $0x8,%esp
     a59:	ff 75 0c             	push   0xc(%ebp)
     a5c:	ff 75 08             	push   0x8(%ebp)
     a5f:	e8 24 ff ff ff       	call   988 <parseblock>
     a64:	83 c4 10             	add    $0x10,%esp
     a67:	e9 fb 00 00 00       	jmp    b67 <parseexec+0x131>

  ret = execcmd();
     a6c:	e8 58 f9 ff ff       	call   3c9 <execcmd>
     a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a74:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a77:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     a81:	83 ec 04             	sub    $0x4,%esp
     a84:	ff 75 0c             	push   0xc(%ebp)
     a87:	ff 75 08             	push   0x8(%ebp)
     a8a:	ff 75 f0             	push   -0x10(%ebp)
     a8d:	e8 0e fe ff ff       	call   8a0 <parseredirs>
     a92:	83 c4 10             	add    $0x10,%esp
     a95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     a98:	e9 87 00 00 00       	jmp    b24 <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     a9d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     aa0:	50                   	push   %eax
     aa1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     aa4:	50                   	push   %eax
     aa5:	ff 75 0c             	push   0xc(%ebp)
     aa8:	ff 75 08             	push   0x8(%ebp)
     aab:	e8 81 fa ff ff       	call   531 <gettoken>
     ab0:	83 c4 10             	add    $0x10,%esp
     ab3:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ab6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     aba:	0f 84 84 00 00 00    	je     b44 <parseexec+0x10e>
      break;
    if(tok != 'a')
     ac0:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     ac4:	74 10                	je     ad6 <parseexec+0xa0>
      panic("syntax");
     ac6:	83 ec 0c             	sub    $0xc,%esp
     ac9:	68 66 14 00 00       	push   $0x1466
     ace:	e8 ad f8 ff ff       	call   380 <panic>
     ad3:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     ad6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     ad9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     adc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     adf:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     ae3:	8b 55 e0             	mov    -0x20(%ebp),%edx
     ae6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     aec:	83 c1 08             	add    $0x8,%ecx
     aef:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     af3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     af7:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     afb:	7e 10                	jle    b0d <parseexec+0xd7>
      panic("too many args");
     afd:	83 ec 0c             	sub    $0xc,%esp
     b00:	68 b5 14 00 00       	push   $0x14b5
     b05:	e8 76 f8 ff ff       	call   380 <panic>
     b0a:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b0d:	83 ec 04             	sub    $0x4,%esp
     b10:	ff 75 0c             	push   0xc(%ebp)
     b13:	ff 75 08             	push   0x8(%ebp)
     b16:	ff 75 f0             	push   -0x10(%ebp)
     b19:	e8 82 fd ff ff       	call   8a0 <parseredirs>
     b1e:	83 c4 10             	add    $0x10,%esp
     b21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     b24:	83 ec 04             	sub    $0x4,%esp
     b27:	68 c3 14 00 00       	push   $0x14c3
     b2c:	ff 75 0c             	push   0xc(%ebp)
     b2f:	ff 75 08             	push   0x8(%ebp)
     b32:	e8 4a fb ff ff       	call   681 <peek>
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	85 c0                	test   %eax,%eax
     b3c:	0f 84 5b ff ff ff    	je     a9d <parseexec+0x67>
     b42:	eb 01                	jmp    b45 <parseexec+0x10f>
      break;
     b44:	90                   	nop
  }
  cmd->argv[argc] = 0;
     b45:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b48:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b4b:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b52:	00 
  cmd->eargv[argc] = 0;
     b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b56:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b59:	83 c2 08             	add    $0x8,%edx
     b5c:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b63:	00 
  return ret;
     b64:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b67:	c9                   	leave
     b68:	c3                   	ret

00000b69 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b69:	55                   	push   %ebp
     b6a:	89 e5                	mov    %esp,%ebp
     b6c:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b6f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b73:	75 0a                	jne    b7f <nulterminate+0x16>
    return 0;
     b75:	b8 00 00 00 00       	mov    $0x0,%eax
     b7a:	e9 e4 00 00 00       	jmp    c63 <nulterminate+0xfa>
  
  switch(cmd->type){
     b7f:	8b 45 08             	mov    0x8(%ebp),%eax
     b82:	8b 00                	mov    (%eax),%eax
     b84:	83 f8 05             	cmp    $0x5,%eax
     b87:	0f 87 d3 00 00 00    	ja     c60 <nulterminate+0xf7>
     b8d:	8b 04 85 c8 14 00 00 	mov    0x14c8(,%eax,4),%eax
     b94:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     b96:	8b 45 08             	mov    0x8(%ebp),%eax
     b99:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     b9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ba3:	eb 14                	jmp    bb9 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     ba5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ba8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bab:	83 c2 08             	add    $0x8,%edx
     bae:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bb2:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
     bb5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bb9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bbc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bbf:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bc3:	85 c0                	test   %eax,%eax
     bc5:	75 de                	jne    ba5 <nulterminate+0x3c>
    break;
     bc7:	e9 94 00 00 00       	jmp    c60 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     bcc:	8b 45 08             	mov    0x8(%ebp),%eax
     bcf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(rcmd->cmd);
     bd2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bd5:	8b 40 04             	mov    0x4(%eax),%eax
     bd8:	83 ec 0c             	sub    $0xc,%esp
     bdb:	50                   	push   %eax
     bdc:	e8 88 ff ff ff       	call   b69 <nulterminate>
     be1:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     be4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     be7:	8b 40 0c             	mov    0xc(%eax),%eax
     bea:	c6 00 00             	movb   $0x0,(%eax)
    break;
     bed:	eb 71                	jmp    c60 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     bef:	8b 45 08             	mov    0x8(%ebp),%eax
     bf2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     bf5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bf8:	8b 40 04             	mov    0x4(%eax),%eax
     bfb:	83 ec 0c             	sub    $0xc,%esp
     bfe:	50                   	push   %eax
     bff:	e8 65 ff ff ff       	call   b69 <nulterminate>
     c04:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     c07:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c0a:	8b 40 08             	mov    0x8(%eax),%eax
     c0d:	83 ec 0c             	sub    $0xc,%esp
     c10:	50                   	push   %eax
     c11:	e8 53 ff ff ff       	call   b69 <nulterminate>
     c16:	83 c4 10             	add    $0x10,%esp
    break;
     c19:	eb 45                	jmp    c60 <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     c1b:	8b 45 08             	mov    0x8(%ebp),%eax
     c1e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
     c21:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c24:	8b 40 04             	mov    0x4(%eax),%eax
     c27:	83 ec 0c             	sub    $0xc,%esp
     c2a:	50                   	push   %eax
     c2b:	e8 39 ff ff ff       	call   b69 <nulterminate>
     c30:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c33:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c36:	8b 40 08             	mov    0x8(%eax),%eax
     c39:	83 ec 0c             	sub    $0xc,%esp
     c3c:	50                   	push   %eax
     c3d:	e8 27 ff ff ff       	call   b69 <nulterminate>
     c42:	83 c4 10             	add    $0x10,%esp
    break;
     c45:	eb 19                	jmp    c60 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c47:	8b 45 08             	mov    0x8(%ebp),%eax
     c4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(bcmd->cmd);
     c4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c50:	8b 40 04             	mov    0x4(%eax),%eax
     c53:	83 ec 0c             	sub    $0xc,%esp
     c56:	50                   	push   %eax
     c57:	e8 0d ff ff ff       	call   b69 <nulterminate>
     c5c:	83 c4 10             	add    $0x10,%esp
    break;
     c5f:	90                   	nop
  }
  return cmd;
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c63:	c9                   	leave
     c64:	c3                   	ret

00000c65 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c65:	55                   	push   %ebp
     c66:	89 e5                	mov    %esp,%ebp
     c68:	57                   	push   %edi
     c69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c6d:	8b 55 10             	mov    0x10(%ebp),%edx
     c70:	8b 45 0c             	mov    0xc(%ebp),%eax
     c73:	89 cb                	mov    %ecx,%ebx
     c75:	89 df                	mov    %ebx,%edi
     c77:	89 d1                	mov    %edx,%ecx
     c79:	fc                   	cld
     c7a:	f3 aa                	rep stos %al,%es:(%edi)
     c7c:	89 ca                	mov    %ecx,%edx
     c7e:	89 fb                	mov    %edi,%ebx
     c80:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c86:	90                   	nop
     c87:	5b                   	pop    %ebx
     c88:	5f                   	pop    %edi
     c89:	5d                   	pop    %ebp
     c8a:	c3                   	ret

00000c8b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     c8b:	55                   	push   %ebp
     c8c:	89 e5                	mov    %esp,%ebp
     c8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     c91:	8b 45 08             	mov    0x8(%ebp),%eax
     c94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     c97:	90                   	nop
     c98:	8b 55 0c             	mov    0xc(%ebp),%edx
     c9b:	8d 42 01             	lea    0x1(%edx),%eax
     c9e:	89 45 0c             	mov    %eax,0xc(%ebp)
     ca1:	8b 45 08             	mov    0x8(%ebp),%eax
     ca4:	8d 48 01             	lea    0x1(%eax),%ecx
     ca7:	89 4d 08             	mov    %ecx,0x8(%ebp)
     caa:	0f b6 12             	movzbl (%edx),%edx
     cad:	88 10                	mov    %dl,(%eax)
     caf:	0f b6 00             	movzbl (%eax),%eax
     cb2:	84 c0                	test   %al,%al
     cb4:	75 e2                	jne    c98 <strcpy+0xd>
    ;
  return os;
     cb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cb9:	c9                   	leave
     cba:	c3                   	ret

00000cbb <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cbb:	55                   	push   %ebp
     cbc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cbe:	eb 08                	jmp    cc8 <strcmp+0xd>
    p++, q++;
     cc0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cc4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     cc8:	8b 45 08             	mov    0x8(%ebp),%eax
     ccb:	0f b6 00             	movzbl (%eax),%eax
     cce:	84 c0                	test   %al,%al
     cd0:	74 10                	je     ce2 <strcmp+0x27>
     cd2:	8b 45 08             	mov    0x8(%ebp),%eax
     cd5:	0f b6 10             	movzbl (%eax),%edx
     cd8:	8b 45 0c             	mov    0xc(%ebp),%eax
     cdb:	0f b6 00             	movzbl (%eax),%eax
     cde:	38 c2                	cmp    %al,%dl
     ce0:	74 de                	je     cc0 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     ce2:	8b 45 08             	mov    0x8(%ebp),%eax
     ce5:	0f b6 00             	movzbl (%eax),%eax
     ce8:	0f b6 d0             	movzbl %al,%edx
     ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
     cee:	0f b6 00             	movzbl (%eax),%eax
     cf1:	0f b6 c0             	movzbl %al,%eax
     cf4:	29 c2                	sub    %eax,%edx
     cf6:	89 d0                	mov    %edx,%eax
}
     cf8:	5d                   	pop    %ebp
     cf9:	c3                   	ret

00000cfa <strlen>:

uint
strlen(char *s)
{
     cfa:	55                   	push   %ebp
     cfb:	89 e5                	mov    %esp,%ebp
     cfd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d00:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d07:	eb 04                	jmp    d0d <strlen+0x13>
     d09:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d10:	8b 45 08             	mov    0x8(%ebp),%eax
     d13:	01 d0                	add    %edx,%eax
     d15:	0f b6 00             	movzbl (%eax),%eax
     d18:	84 c0                	test   %al,%al
     d1a:	75 ed                	jne    d09 <strlen+0xf>
    ;
  return n;
     d1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d1f:	c9                   	leave
     d20:	c3                   	ret

00000d21 <memset>:

void*
memset(void *dst, int c, uint n)
{
     d21:	55                   	push   %ebp
     d22:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d24:	8b 45 10             	mov    0x10(%ebp),%eax
     d27:	50                   	push   %eax
     d28:	ff 75 0c             	push   0xc(%ebp)
     d2b:	ff 75 08             	push   0x8(%ebp)
     d2e:	e8 32 ff ff ff       	call   c65 <stosb>
     d33:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d36:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d39:	c9                   	leave
     d3a:	c3                   	ret

00000d3b <strchr>:

char*
strchr(const char *s, char c)
{
     d3b:	55                   	push   %ebp
     d3c:	89 e5                	mov    %esp,%ebp
     d3e:	83 ec 04             	sub    $0x4,%esp
     d41:	8b 45 0c             	mov    0xc(%ebp),%eax
     d44:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d47:	eb 14                	jmp    d5d <strchr+0x22>
    if(*s == c)
     d49:	8b 45 08             	mov    0x8(%ebp),%eax
     d4c:	0f b6 00             	movzbl (%eax),%eax
     d4f:	38 45 fc             	cmp    %al,-0x4(%ebp)
     d52:	75 05                	jne    d59 <strchr+0x1e>
      return (char*)s;
     d54:	8b 45 08             	mov    0x8(%ebp),%eax
     d57:	eb 13                	jmp    d6c <strchr+0x31>
  for(; *s; s++)
     d59:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d5d:	8b 45 08             	mov    0x8(%ebp),%eax
     d60:	0f b6 00             	movzbl (%eax),%eax
     d63:	84 c0                	test   %al,%al
     d65:	75 e2                	jne    d49 <strchr+0xe>
  return 0;
     d67:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d6c:	c9                   	leave
     d6d:	c3                   	ret

00000d6e <gets>:

char*
gets(char *buf, int max)
{
     d6e:	55                   	push   %ebp
     d6f:	89 e5                	mov    %esp,%ebp
     d71:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d7b:	eb 42                	jmp    dbf <gets+0x51>
    cc = read(0, &c, 1);
     d7d:	83 ec 04             	sub    $0x4,%esp
     d80:	6a 01                	push   $0x1
     d82:	8d 45 ef             	lea    -0x11(%ebp),%eax
     d85:	50                   	push   %eax
     d86:	6a 00                	push   $0x0
     d88:	e8 47 01 00 00       	call   ed4 <read>
     d8d:	83 c4 10             	add    $0x10,%esp
     d90:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     d93:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d97:	7e 33                	jle    dcc <gets+0x5e>
      break;
    buf[i++] = c;
     d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d9c:	8d 50 01             	lea    0x1(%eax),%edx
     d9f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     da2:	89 c2                	mov    %eax,%edx
     da4:	8b 45 08             	mov    0x8(%ebp),%eax
     da7:	01 c2                	add    %eax,%edx
     da9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     daf:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     db3:	3c 0a                	cmp    $0xa,%al
     db5:	74 16                	je     dcd <gets+0x5f>
     db7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dbb:	3c 0d                	cmp    $0xd,%al
     dbd:	74 0e                	je     dcd <gets+0x5f>
  for(i=0; i+1 < max; ){
     dbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dc2:	83 c0 01             	add    $0x1,%eax
     dc5:	39 45 0c             	cmp    %eax,0xc(%ebp)
     dc8:	7f b3                	jg     d7d <gets+0xf>
     dca:	eb 01                	jmp    dcd <gets+0x5f>
      break;
     dcc:	90                   	nop
      break;
  }
  buf[i] = '\0';
     dcd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     dd0:	8b 45 08             	mov    0x8(%ebp),%eax
     dd3:	01 d0                	add    %edx,%eax
     dd5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     dd8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ddb:	c9                   	leave
     ddc:	c3                   	ret

00000ddd <stat>:

int
stat(char *n, struct stat *st)
{
     ddd:	55                   	push   %ebp
     dde:	89 e5                	mov    %esp,%ebp
     de0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     de3:	83 ec 08             	sub    $0x8,%esp
     de6:	6a 00                	push   $0x0
     de8:	ff 75 08             	push   0x8(%ebp)
     deb:	e8 0c 01 00 00       	call   efc <open>
     df0:	83 c4 10             	add    $0x10,%esp
     df3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     df6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dfa:	79 07                	jns    e03 <stat+0x26>
    return -1;
     dfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e01:	eb 25                	jmp    e28 <stat+0x4b>
  r = fstat(fd, st);
     e03:	83 ec 08             	sub    $0x8,%esp
     e06:	ff 75 0c             	push   0xc(%ebp)
     e09:	ff 75 f4             	push   -0xc(%ebp)
     e0c:	e8 03 01 00 00       	call   f14 <fstat>
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     e17:	83 ec 0c             	sub    $0xc,%esp
     e1a:	ff 75 f4             	push   -0xc(%ebp)
     e1d:	e8 c2 00 00 00       	call   ee4 <close>
     e22:	83 c4 10             	add    $0x10,%esp
  return r;
     e25:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e28:	c9                   	leave
     e29:	c3                   	ret

00000e2a <atoi>:

int
atoi(const char *s)
{
     e2a:	55                   	push   %ebp
     e2b:	89 e5                	mov    %esp,%ebp
     e2d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e37:	eb 25                	jmp    e5e <atoi+0x34>
    n = n*10 + *s++ - '0';
     e39:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e3c:	89 d0                	mov    %edx,%eax
     e3e:	c1 e0 02             	shl    $0x2,%eax
     e41:	01 d0                	add    %edx,%eax
     e43:	01 c0                	add    %eax,%eax
     e45:	89 c1                	mov    %eax,%ecx
     e47:	8b 45 08             	mov    0x8(%ebp),%eax
     e4a:	8d 50 01             	lea    0x1(%eax),%edx
     e4d:	89 55 08             	mov    %edx,0x8(%ebp)
     e50:	0f b6 00             	movzbl (%eax),%eax
     e53:	0f be c0             	movsbl %al,%eax
     e56:	01 c8                	add    %ecx,%eax
     e58:	83 e8 30             	sub    $0x30,%eax
     e5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e5e:	8b 45 08             	mov    0x8(%ebp),%eax
     e61:	0f b6 00             	movzbl (%eax),%eax
     e64:	3c 2f                	cmp    $0x2f,%al
     e66:	7e 0a                	jle    e72 <atoi+0x48>
     e68:	8b 45 08             	mov    0x8(%ebp),%eax
     e6b:	0f b6 00             	movzbl (%eax),%eax
     e6e:	3c 39                	cmp    $0x39,%al
     e70:	7e c7                	jle    e39 <atoi+0xf>
  return n;
     e72:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e75:	c9                   	leave
     e76:	c3                   	ret

00000e77 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e77:	55                   	push   %ebp
     e78:	89 e5                	mov    %esp,%ebp
     e7a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     e7d:	8b 45 08             	mov    0x8(%ebp),%eax
     e80:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     e83:	8b 45 0c             	mov    0xc(%ebp),%eax
     e86:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     e89:	eb 17                	jmp    ea2 <memmove+0x2b>
    *dst++ = *src++;
     e8b:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e8e:	8d 42 01             	lea    0x1(%edx),%eax
     e91:	89 45 f8             	mov    %eax,-0x8(%ebp)
     e94:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e97:	8d 48 01             	lea    0x1(%eax),%ecx
     e9a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     e9d:	0f b6 12             	movzbl (%edx),%edx
     ea0:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     ea2:	8b 45 10             	mov    0x10(%ebp),%eax
     ea5:	8d 50 ff             	lea    -0x1(%eax),%edx
     ea8:	89 55 10             	mov    %edx,0x10(%ebp)
     eab:	85 c0                	test   %eax,%eax
     ead:	7f dc                	jg     e8b <memmove+0x14>
  return vdst;
     eaf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     eb2:	c9                   	leave
     eb3:	c3                   	ret

00000eb4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     eb4:	b8 01 00 00 00       	mov    $0x1,%eax
     eb9:	cd 40                	int    $0x40
     ebb:	c3                   	ret

00000ebc <exit>:
SYSCALL(exit)
     ebc:	b8 02 00 00 00       	mov    $0x2,%eax
     ec1:	cd 40                	int    $0x40
     ec3:	c3                   	ret

00000ec4 <wait>:
SYSCALL(wait)
     ec4:	b8 03 00 00 00       	mov    $0x3,%eax
     ec9:	cd 40                	int    $0x40
     ecb:	c3                   	ret

00000ecc <pipe>:
SYSCALL(pipe)
     ecc:	b8 04 00 00 00       	mov    $0x4,%eax
     ed1:	cd 40                	int    $0x40
     ed3:	c3                   	ret

00000ed4 <read>:
SYSCALL(read)
     ed4:	b8 05 00 00 00       	mov    $0x5,%eax
     ed9:	cd 40                	int    $0x40
     edb:	c3                   	ret

00000edc <write>:
SYSCALL(write)
     edc:	b8 10 00 00 00       	mov    $0x10,%eax
     ee1:	cd 40                	int    $0x40
     ee3:	c3                   	ret

00000ee4 <close>:
SYSCALL(close)
     ee4:	b8 15 00 00 00       	mov    $0x15,%eax
     ee9:	cd 40                	int    $0x40
     eeb:	c3                   	ret

00000eec <kill>:
SYSCALL(kill)
     eec:	b8 06 00 00 00       	mov    $0x6,%eax
     ef1:	cd 40                	int    $0x40
     ef3:	c3                   	ret

00000ef4 <exec>:
SYSCALL(exec)
     ef4:	b8 07 00 00 00       	mov    $0x7,%eax
     ef9:	cd 40                	int    $0x40
     efb:	c3                   	ret

00000efc <open>:
SYSCALL(open)
     efc:	b8 0f 00 00 00       	mov    $0xf,%eax
     f01:	cd 40                	int    $0x40
     f03:	c3                   	ret

00000f04 <mknod>:
SYSCALL(mknod)
     f04:	b8 11 00 00 00       	mov    $0x11,%eax
     f09:	cd 40                	int    $0x40
     f0b:	c3                   	ret

00000f0c <unlink>:
SYSCALL(unlink)
     f0c:	b8 12 00 00 00       	mov    $0x12,%eax
     f11:	cd 40                	int    $0x40
     f13:	c3                   	ret

00000f14 <fstat>:
SYSCALL(fstat)
     f14:	b8 08 00 00 00       	mov    $0x8,%eax
     f19:	cd 40                	int    $0x40
     f1b:	c3                   	ret

00000f1c <link>:
SYSCALL(link)
     f1c:	b8 13 00 00 00       	mov    $0x13,%eax
     f21:	cd 40                	int    $0x40
     f23:	c3                   	ret

00000f24 <mkdir>:
SYSCALL(mkdir)
     f24:	b8 14 00 00 00       	mov    $0x14,%eax
     f29:	cd 40                	int    $0x40
     f2b:	c3                   	ret

00000f2c <chdir>:
SYSCALL(chdir)
     f2c:	b8 09 00 00 00       	mov    $0x9,%eax
     f31:	cd 40                	int    $0x40
     f33:	c3                   	ret

00000f34 <dup>:
SYSCALL(dup)
     f34:	b8 0a 00 00 00       	mov    $0xa,%eax
     f39:	cd 40                	int    $0x40
     f3b:	c3                   	ret

00000f3c <getpid>:
SYSCALL(getpid)
     f3c:	b8 0b 00 00 00       	mov    $0xb,%eax
     f41:	cd 40                	int    $0x40
     f43:	c3                   	ret

00000f44 <sbrk>:
SYSCALL(sbrk)
     f44:	b8 0c 00 00 00       	mov    $0xc,%eax
     f49:	cd 40                	int    $0x40
     f4b:	c3                   	ret

00000f4c <sleep>:
SYSCALL(sleep)
     f4c:	b8 0d 00 00 00       	mov    $0xd,%eax
     f51:	cd 40                	int    $0x40
     f53:	c3                   	ret

00000f54 <uptime>:
SYSCALL(uptime)
     f54:	b8 0e 00 00 00       	mov    $0xe,%eax
     f59:	cd 40                	int    $0x40
     f5b:	c3                   	ret

00000f5c <shutdown>:
SYSCALL(shutdown)
     f5c:	b8 16 00 00 00       	mov    $0x16,%eax
     f61:	cd 40                	int    $0x40
     f63:	c3                   	ret

00000f64 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f64:	55                   	push   %ebp
     f65:	89 e5                	mov    %esp,%ebp
     f67:	83 ec 18             	sub    $0x18,%esp
     f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f6d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     f70:	83 ec 04             	sub    $0x4,%esp
     f73:	6a 01                	push   $0x1
     f75:	8d 45 f4             	lea    -0xc(%ebp),%eax
     f78:	50                   	push   %eax
     f79:	ff 75 08             	push   0x8(%ebp)
     f7c:	e8 5b ff ff ff       	call   edc <write>
     f81:	83 c4 10             	add    $0x10,%esp
}
     f84:	90                   	nop
     f85:	c9                   	leave
     f86:	c3                   	ret

00000f87 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f87:	55                   	push   %ebp
     f88:	89 e5                	mov    %esp,%ebp
     f8a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f8d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     f94:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f98:	74 17                	je     fb1 <printint+0x2a>
     f9a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f9e:	79 11                	jns    fb1 <printint+0x2a>
    neg = 1;
     fa0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
     faa:	f7 d8                	neg    %eax
     fac:	89 45 ec             	mov    %eax,-0x14(%ebp)
     faf:	eb 06                	jmp    fb7 <printint+0x30>
  } else {
    x = xx;
     fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
     fb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     fb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     fbe:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fc1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fc4:	ba 00 00 00 00       	mov    $0x0,%edx
     fc9:	f7 f1                	div    %ecx
     fcb:	89 d1                	mov    %edx,%ecx
     fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd0:	8d 50 01             	lea    0x1(%eax),%edx
     fd3:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fd6:	0f b6 91 78 19 00 00 	movzbl 0x1978(%ecx),%edx
     fdd:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     fe1:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fe4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fe7:	ba 00 00 00 00       	mov    $0x0,%edx
     fec:	f7 f1                	div    %ecx
     fee:	89 45 ec             	mov    %eax,-0x14(%ebp)
     ff1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ff5:	75 c7                	jne    fbe <printint+0x37>
  if(neg)
     ff7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ffb:	74 2d                	je     102a <printint+0xa3>
    buf[i++] = '-';
     ffd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1000:	8d 50 01             	lea    0x1(%eax),%edx
    1003:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1006:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    100b:	eb 1d                	jmp    102a <printint+0xa3>
    putc(fd, buf[i]);
    100d:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1010:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1013:	01 d0                	add    %edx,%eax
    1015:	0f b6 00             	movzbl (%eax),%eax
    1018:	0f be c0             	movsbl %al,%eax
    101b:	83 ec 08             	sub    $0x8,%esp
    101e:	50                   	push   %eax
    101f:	ff 75 08             	push   0x8(%ebp)
    1022:	e8 3d ff ff ff       	call   f64 <putc>
    1027:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    102a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    102e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1032:	79 d9                	jns    100d <printint+0x86>
}
    1034:	90                   	nop
    1035:	90                   	nop
    1036:	c9                   	leave
    1037:	c3                   	ret

00001038 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1038:	55                   	push   %ebp
    1039:	89 e5                	mov    %esp,%ebp
    103b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    103e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1045:	8d 45 0c             	lea    0xc(%ebp),%eax
    1048:	83 c0 04             	add    $0x4,%eax
    104b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    104e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1055:	e9 59 01 00 00       	jmp    11b3 <printf+0x17b>
    c = fmt[i] & 0xff;
    105a:	8b 55 0c             	mov    0xc(%ebp),%edx
    105d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1060:	01 d0                	add    %edx,%eax
    1062:	0f b6 00             	movzbl (%eax),%eax
    1065:	0f be c0             	movsbl %al,%eax
    1068:	25 ff 00 00 00       	and    $0xff,%eax
    106d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1070:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1074:	75 2c                	jne    10a2 <printf+0x6a>
      if(c == '%'){
    1076:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    107a:	75 0c                	jne    1088 <printf+0x50>
        state = '%';
    107c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1083:	e9 27 01 00 00       	jmp    11af <printf+0x177>
      } else {
        putc(fd, c);
    1088:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    108b:	0f be c0             	movsbl %al,%eax
    108e:	83 ec 08             	sub    $0x8,%esp
    1091:	50                   	push   %eax
    1092:	ff 75 08             	push   0x8(%ebp)
    1095:	e8 ca fe ff ff       	call   f64 <putc>
    109a:	83 c4 10             	add    $0x10,%esp
    109d:	e9 0d 01 00 00       	jmp    11af <printf+0x177>
      }
    } else if(state == '%'){
    10a2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    10a6:	0f 85 03 01 00 00    	jne    11af <printf+0x177>
      if(c == 'd'){
    10ac:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    10b0:	75 1e                	jne    10d0 <printf+0x98>
        printint(fd, *ap, 10, 1);
    10b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10b5:	8b 00                	mov    (%eax),%eax
    10b7:	6a 01                	push   $0x1
    10b9:	6a 0a                	push   $0xa
    10bb:	50                   	push   %eax
    10bc:	ff 75 08             	push   0x8(%ebp)
    10bf:	e8 c3 fe ff ff       	call   f87 <printint>
    10c4:	83 c4 10             	add    $0x10,%esp
        ap++;
    10c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10cb:	e9 d8 00 00 00       	jmp    11a8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    10d0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    10d4:	74 06                	je     10dc <printf+0xa4>
    10d6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    10da:	75 1e                	jne    10fa <printf+0xc2>
        printint(fd, *ap, 16, 0);
    10dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10df:	8b 00                	mov    (%eax),%eax
    10e1:	6a 00                	push   $0x0
    10e3:	6a 10                	push   $0x10
    10e5:	50                   	push   %eax
    10e6:	ff 75 08             	push   0x8(%ebp)
    10e9:	e8 99 fe ff ff       	call   f87 <printint>
    10ee:	83 c4 10             	add    $0x10,%esp
        ap++;
    10f1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10f5:	e9 ae 00 00 00       	jmp    11a8 <printf+0x170>
      } else if(c == 's'){
    10fa:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    10fe:	75 43                	jne    1143 <printf+0x10b>
        s = (char*)*ap;
    1100:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1103:	8b 00                	mov    (%eax),%eax
    1105:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1108:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    110c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1110:	75 25                	jne    1137 <printf+0xff>
          s = "(null)";
    1112:	c7 45 f4 e0 14 00 00 	movl   $0x14e0,-0xc(%ebp)
        while(*s != 0){
    1119:	eb 1c                	jmp    1137 <printf+0xff>
          putc(fd, *s);
    111b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    111e:	0f b6 00             	movzbl (%eax),%eax
    1121:	0f be c0             	movsbl %al,%eax
    1124:	83 ec 08             	sub    $0x8,%esp
    1127:	50                   	push   %eax
    1128:	ff 75 08             	push   0x8(%ebp)
    112b:	e8 34 fe ff ff       	call   f64 <putc>
    1130:	83 c4 10             	add    $0x10,%esp
          s++;
    1133:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1137:	8b 45 f4             	mov    -0xc(%ebp),%eax
    113a:	0f b6 00             	movzbl (%eax),%eax
    113d:	84 c0                	test   %al,%al
    113f:	75 da                	jne    111b <printf+0xe3>
    1141:	eb 65                	jmp    11a8 <printf+0x170>
        }
      } else if(c == 'c'){
    1143:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1147:	75 1d                	jne    1166 <printf+0x12e>
        putc(fd, *ap);
    1149:	8b 45 e8             	mov    -0x18(%ebp),%eax
    114c:	8b 00                	mov    (%eax),%eax
    114e:	0f be c0             	movsbl %al,%eax
    1151:	83 ec 08             	sub    $0x8,%esp
    1154:	50                   	push   %eax
    1155:	ff 75 08             	push   0x8(%ebp)
    1158:	e8 07 fe ff ff       	call   f64 <putc>
    115d:	83 c4 10             	add    $0x10,%esp
        ap++;
    1160:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1164:	eb 42                	jmp    11a8 <printf+0x170>
      } else if(c == '%'){
    1166:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    116a:	75 17                	jne    1183 <printf+0x14b>
        putc(fd, c);
    116c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    116f:	0f be c0             	movsbl %al,%eax
    1172:	83 ec 08             	sub    $0x8,%esp
    1175:	50                   	push   %eax
    1176:	ff 75 08             	push   0x8(%ebp)
    1179:	e8 e6 fd ff ff       	call   f64 <putc>
    117e:	83 c4 10             	add    $0x10,%esp
    1181:	eb 25                	jmp    11a8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1183:	83 ec 08             	sub    $0x8,%esp
    1186:	6a 25                	push   $0x25
    1188:	ff 75 08             	push   0x8(%ebp)
    118b:	e8 d4 fd ff ff       	call   f64 <putc>
    1190:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1193:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1196:	0f be c0             	movsbl %al,%eax
    1199:	83 ec 08             	sub    $0x8,%esp
    119c:	50                   	push   %eax
    119d:	ff 75 08             	push   0x8(%ebp)
    11a0:	e8 bf fd ff ff       	call   f64 <putc>
    11a5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    11a8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    11af:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    11b3:	8b 55 0c             	mov    0xc(%ebp),%edx
    11b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11b9:	01 d0                	add    %edx,%eax
    11bb:	0f b6 00             	movzbl (%eax),%eax
    11be:	84 c0                	test   %al,%al
    11c0:	0f 85 94 fe ff ff    	jne    105a <printf+0x22>
    }
  }
}
    11c6:	90                   	nop
    11c7:	90                   	nop
    11c8:	c9                   	leave
    11c9:	c3                   	ret

000011ca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11ca:	55                   	push   %ebp
    11cb:	89 e5                	mov    %esp,%ebp
    11cd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11d0:	8b 45 08             	mov    0x8(%ebp),%eax
    11d3:	83 e8 08             	sub    $0x8,%eax
    11d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d9:	a1 0c 1a 00 00       	mov    0x1a0c,%eax
    11de:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11e1:	eb 24                	jmp    1207 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11e6:	8b 00                	mov    (%eax),%eax
    11e8:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    11eb:	72 12                	jb     11ff <free+0x35>
    11ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11f0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    11f3:	72 24                	jb     1219 <free+0x4f>
    11f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11f8:	8b 00                	mov    (%eax),%eax
    11fa:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    11fd:	72 1a                	jb     1219 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1202:	8b 00                	mov    (%eax),%eax
    1204:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1207:	8b 45 f8             	mov    -0x8(%ebp),%eax
    120a:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    120d:	73 d4                	jae    11e3 <free+0x19>
    120f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1212:	8b 00                	mov    (%eax),%eax
    1214:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1217:	73 ca                	jae    11e3 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1219:	8b 45 f8             	mov    -0x8(%ebp),%eax
    121c:	8b 40 04             	mov    0x4(%eax),%eax
    121f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1226:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1229:	01 c2                	add    %eax,%edx
    122b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    122e:	8b 00                	mov    (%eax),%eax
    1230:	39 c2                	cmp    %eax,%edx
    1232:	75 24                	jne    1258 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1234:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1237:	8b 50 04             	mov    0x4(%eax),%edx
    123a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    123d:	8b 00                	mov    (%eax),%eax
    123f:	8b 40 04             	mov    0x4(%eax),%eax
    1242:	01 c2                	add    %eax,%edx
    1244:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1247:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    124a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    124d:	8b 00                	mov    (%eax),%eax
    124f:	8b 10                	mov    (%eax),%edx
    1251:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1254:	89 10                	mov    %edx,(%eax)
    1256:	eb 0a                	jmp    1262 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1258:	8b 45 fc             	mov    -0x4(%ebp),%eax
    125b:	8b 10                	mov    (%eax),%edx
    125d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1260:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1262:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1265:	8b 40 04             	mov    0x4(%eax),%eax
    1268:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    126f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1272:	01 d0                	add    %edx,%eax
    1274:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1277:	75 20                	jne    1299 <free+0xcf>
    p->s.size += bp->s.size;
    1279:	8b 45 fc             	mov    -0x4(%ebp),%eax
    127c:	8b 50 04             	mov    0x4(%eax),%edx
    127f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1282:	8b 40 04             	mov    0x4(%eax),%eax
    1285:	01 c2                	add    %eax,%edx
    1287:	8b 45 fc             	mov    -0x4(%ebp),%eax
    128a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    128d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1290:	8b 10                	mov    (%eax),%edx
    1292:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1295:	89 10                	mov    %edx,(%eax)
    1297:	eb 08                	jmp    12a1 <free+0xd7>
  } else
    p->s.ptr = bp;
    1299:	8b 45 fc             	mov    -0x4(%ebp),%eax
    129c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    129f:	89 10                	mov    %edx,(%eax)
  freep = p;
    12a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12a4:	a3 0c 1a 00 00       	mov    %eax,0x1a0c
}
    12a9:	90                   	nop
    12aa:	c9                   	leave
    12ab:	c3                   	ret

000012ac <morecore>:

static Header*
morecore(uint nu)
{
    12ac:	55                   	push   %ebp
    12ad:	89 e5                	mov    %esp,%ebp
    12af:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    12b2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    12b9:	77 07                	ja     12c2 <morecore+0x16>
    nu = 4096;
    12bb:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    12c2:	8b 45 08             	mov    0x8(%ebp),%eax
    12c5:	c1 e0 03             	shl    $0x3,%eax
    12c8:	83 ec 0c             	sub    $0xc,%esp
    12cb:	50                   	push   %eax
    12cc:	e8 73 fc ff ff       	call   f44 <sbrk>
    12d1:	83 c4 10             	add    $0x10,%esp
    12d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    12d7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    12db:	75 07                	jne    12e4 <morecore+0x38>
    return 0;
    12dd:	b8 00 00 00 00       	mov    $0x0,%eax
    12e2:	eb 26                	jmp    130a <morecore+0x5e>
  hp = (Header*)p;
    12e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    12ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12ed:	8b 55 08             	mov    0x8(%ebp),%edx
    12f0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    12f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f6:	83 c0 08             	add    $0x8,%eax
    12f9:	83 ec 0c             	sub    $0xc,%esp
    12fc:	50                   	push   %eax
    12fd:	e8 c8 fe ff ff       	call   11ca <free>
    1302:	83 c4 10             	add    $0x10,%esp
  return freep;
    1305:	a1 0c 1a 00 00       	mov    0x1a0c,%eax
}
    130a:	c9                   	leave
    130b:	c3                   	ret

0000130c <malloc>:

void*
malloc(uint nbytes)
{
    130c:	55                   	push   %ebp
    130d:	89 e5                	mov    %esp,%ebp
    130f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1312:	8b 45 08             	mov    0x8(%ebp),%eax
    1315:	83 c0 07             	add    $0x7,%eax
    1318:	c1 e8 03             	shr    $0x3,%eax
    131b:	83 c0 01             	add    $0x1,%eax
    131e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1321:	a1 0c 1a 00 00       	mov    0x1a0c,%eax
    1326:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1329:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    132d:	75 23                	jne    1352 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    132f:	c7 45 f0 04 1a 00 00 	movl   $0x1a04,-0x10(%ebp)
    1336:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1339:	a3 0c 1a 00 00       	mov    %eax,0x1a0c
    133e:	a1 0c 1a 00 00       	mov    0x1a0c,%eax
    1343:	a3 04 1a 00 00       	mov    %eax,0x1a04
    base.s.size = 0;
    1348:	c7 05 08 1a 00 00 00 	movl   $0x0,0x1a08
    134f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1352:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1355:	8b 00                	mov    (%eax),%eax
    1357:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    135a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135d:	8b 40 04             	mov    0x4(%eax),%eax
    1360:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1363:	72 4d                	jb     13b2 <malloc+0xa6>
      if(p->s.size == nunits)
    1365:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1368:	8b 40 04             	mov    0x4(%eax),%eax
    136b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    136e:	75 0c                	jne    137c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1370:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1373:	8b 10                	mov    (%eax),%edx
    1375:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1378:	89 10                	mov    %edx,(%eax)
    137a:	eb 26                	jmp    13a2 <malloc+0x96>
      else {
        p->s.size -= nunits;
    137c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    137f:	8b 40 04             	mov    0x4(%eax),%eax
    1382:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1385:	89 c2                	mov    %eax,%edx
    1387:	8b 45 f4             	mov    -0xc(%ebp),%eax
    138a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    138d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1390:	8b 40 04             	mov    0x4(%eax),%eax
    1393:	c1 e0 03             	shl    $0x3,%eax
    1396:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1399:	8b 45 f4             	mov    -0xc(%ebp),%eax
    139c:	8b 55 ec             	mov    -0x14(%ebp),%edx
    139f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    13a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13a5:	a3 0c 1a 00 00       	mov    %eax,0x1a0c
      return (void*)(p + 1);
    13aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ad:	83 c0 08             	add    $0x8,%eax
    13b0:	eb 3b                	jmp    13ed <malloc+0xe1>
    }
    if(p == freep)
    13b2:	a1 0c 1a 00 00       	mov    0x1a0c,%eax
    13b7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    13ba:	75 1e                	jne    13da <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    13bc:	83 ec 0c             	sub    $0xc,%esp
    13bf:	ff 75 ec             	push   -0x14(%ebp)
    13c2:	e8 e5 fe ff ff       	call   12ac <morecore>
    13c7:	83 c4 10             	add    $0x10,%esp
    13ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13d1:	75 07                	jne    13da <malloc+0xce>
        return 0;
    13d3:	b8 00 00 00 00       	mov    $0x0,%eax
    13d8:	eb 13                	jmp    13ed <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13da:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    13e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e3:	8b 00                	mov    (%eax),%eax
    13e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13e8:	e9 6d ff ff ff       	jmp    135a <malloc+0x4e>
  }
}
    13ed:	c9                   	leave
    13ee:	c3                   	ret
