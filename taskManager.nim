import strutils

proc printTODOlist(filename: string) =
    var
        fileHandle: File
        content: seq[string]
        i: int = 0

    if open(fileHandle, filename, fmRead):
        content = readAll(fileHandle).splitLines()
        for line in content:
            if i == 0:
                inc(i)
                continue
            echo i, " -> ", line
            inc(i)
        close(fileHandle)
    else:
        echo "[-] Some error occurred"

proc addTask(task: string) =
    var
        fileName: File
        content: seq[string]

    if open(fileName, "task.txt", fmRead):
        content = readAll(fileName).splitLines()
        close(fileName)

    if content.len == 0:
        content = @[task]
    else:
        content.add(task)

    if open(fileName, "task.txt", fmWrite):
        write(fileName, content.join("\n"))
        close(fileName)
    else:
        echo "[-] Some error occurred"

echo "before \n"
printTODOlist("task.txt")
addTask("test task")
echo "after \n"
printTODOlist("task.txt")
