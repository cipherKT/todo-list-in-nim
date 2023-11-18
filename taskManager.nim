import strutils

# this function prints the todo list
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
        echo "[!] Some error occurred"

# this function is made to add task in a todo list 
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
        echo "[!] Some error occurred"

# this function is made to remove a task in a todo list 
proc removeTask(index: int) =
    var
        fileHandle: File  
        content: seq[string]

    if open(fileHandle, "task.txt", fmRead):  
        content = readAll(fileHandle).splitLines()
        close(fileHandle)

    if index < 0 or index >= len(content):
        echo "[!] Index out of range"
    else:
        delete(content, index)

        if open(fileHandle, "task.txt", fmWrite):  
            write(fileHandle, content.join("\n"))
            close(fileHandle)
        else:
            echo "[!] Some error occurred"
# this function is made to clear whole todo list 
proc clearTODOlist()=
    var fileHandle:File
    if open(fileHandle,"task.txt",fmWrite) :
        discard
    else:
        echo "[!]Some Error Occurred"
# driver code
proc main() =
    while true:
        echo "\nChoose an option:"
        echo "1. print TO-DO list"
        echo "2. Add new Task"
        echo "3. Remove existing Task"
        echo "4. Clear the List"
        echo "5. Quit"

        let choice = readLine(stdin)

        case choice
        of "1":
            printTODOlist("task.txt")  
        of "2":
            echo "Enter task that you want to add : "
            let taskToAdd = readLine(stdin)
            addTask(taskToAdd)
        of "3":
            echo "Enter index of the task that you want to remove : "
            let indexOfRemovedTask = parseInt(readLine(stdin))
            removeTask(indexOfRemovedTask)
        of "4":
            clearTODOlist()
        of "5":
            break

main()
