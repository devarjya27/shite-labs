student@sce-cl11-34:~/240968040$ date
Wednesday 14 January 2026 09:06:55 AM IST
student@sce-cl11-34:~/240968040$ echo "Devarjya Purkayastha 240968040"
Devarjya Purkayastha 240968040

# Execute and write output of any 5 important commands explained so far in this manual. Save the output in Lab1_1.txt . Commands and the output copied from the command prompt.
student@sce-cl11-34:~/240968040$ touch ex1
student@sce-cl11-34:~/240968040$ echo "hi" > ex1
student@sce-cl11-34:~/240968040$ cat ex1
hi
student@sce-cl11-34:~/240968040$ cp ex1 ex2
student@sce-cl11-34:~/240968040$ cat ex2
hi
student@sce-cl11-34:~/240968040$ head ex1
hi
student@sce-cl11-34:~/240968040$ rm ex1
student@sce-cl11-34:~/240968040$ cat ex1
cat: ex1: No such file or directory
student@sce-cl11-34:~/240968040$ mkdir 2ex
student@sce-cl11-34:~/240968040$ whereis whoami
whoami: /usr/bin/whoami /usr/share/man/man1/whoami.1.gz

# Explore the following commands along with their various options. (Some of the options are specified in the bracket)
# cat (variation used to create a new file and append to existing file)

student@sce-cl11-34:~/240968040$ cat ex1
bye
hi
yes
no
who
where
when
what

# head and tail (-n, -c )
student@sce-cl11-34:~/240968040$ head -n 5 ex1
bye
hi
yes
no
who
student@sce-cl11-34:~/240968040$ tail -n 5 ex1
no
who
where
when
what
student@sce-cl11-34:~/240968040$ head -c 10 ex1
bye
hi
yes
student@sce-cl11-34:~/240968040$ tail -c 10 ex1
when
what

# cp (-n, -i, -f)
student@sce-cl11-34:~/240968040$ cat ex2
hi
student@sce-cl11-34:~/240968040$ cat ex1
bye
hi
yes
no
who
where
when
what
student@sce-cl11-34:~/240968040$ cp -f ex1 ex2
student@sce-cl11-34:~/240968040$ cat ex2
bye
hi
yes
no
who
where
when
what

student@sce-cl11-34:~/240968040$ cat ex2
hi
student@sce-cl11-34:~/240968040$ cp -i ex1 ex2
cp: overwrite 'ex2'? yes
student@sce-cl11-34:~/240968040$ cat ex2
bye
hi
yes
no
who
where
when
what

student@sce-cl11-34:~/240968040$ cat ex2
hi
student@sce-cl11-34:~/240968040$ cp -n ex1 ex2
student@sce-cl11-34:~/240968040$ cat ex2
hi

# mv (-f, -i) [try (i) mv dir1 dir2 (ii) mv file1 file2 file3 ... directory]
student@sce-cl11-34:~/240968040$ ls 1ex
file1
student@sce-cl11-34:~/240968040$ ls 2ex
student@sce-cl11-34:~/240968040$ mv -i 1ex 2ex
student@sce-cl11-34:~/240968040$ ls 2ex
1ex
student@sce-cl11-34:~/240968040$ mv ex1 ex2 2ex
student@sce-cl11-34:~/240968040$ ls 2ex
1ex  ex1  ex2

# rm (-r, -i, -f)
student@sce-cl11-34:~/240968040/2ex$ ls
1ex  ex1  ex2
student@sce-cl11-34:~/240968040/2ex$ rm -r -i 1ex
rm: descend into directory '1ex'? yes
rm: remove regular empty file '1ex/file1'? yes
rm: remove directory '1ex'? yes
student@sce-cl11-34:~/240968040/2ex$ ls
ex1  ex2

# rmdir (-r, -f)
student@sce-cl11-34:~/240968040$ mkdir -p q2_a/q2_b
student@sce-cl11-34:~/240968040$ ls q2_a
q2_b
student@sce-cl11-34:~/240968040$ rmdir -p q2_a/q2_b
student@sce-cl11-34:~/240968040$ ls q2_a
ls: cannot access 'q2_a': No such file or directory

# find (-name, -type)
student@sce-cl11-34:~/240968040$ find 2ex
2ex
2ex/ex2
2ex/ex1
student@sce-cl11-34:~/240968040$ find -name Lab1_1.txt
./Lab1_1.txt
student@sce-cl11-34:~/240968040$ find -type f
./Lab1_1.txt
./2ex/ex2
./2ex/ex1
./OS lab manual_2026.pdf
student@sce-cl11-34:~/240968040$ find -type d
.
./2ex



