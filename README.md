# Make-it-easy
I saw many of my friends to handle docking result files to analyze. They were handling thousands of file individually. So, I wrote simple dos and Linux command to make their work easy. 


**Extracting the log files from many other file  types**

Let's say, a folder contains many files with different file types and we need files from a single file type so simple command to that will be copying it to other folder:

```
cp <path>*.<file type> <path of destination folder>
```

Example, 

```
cp *.log Templog
```

So, this command can be run in windows cmd and linux to get all files with extension "log" from the current directory into a folder named Templog.
If you have files elsewhere, you have to provide the correct path.


Let us say that we have log files in different folders, of similar pattern obtained from docking analysis, then we have to perform a batch extraction of the files

Sample code:

```
#!/bin/bash
for FILE in <Folder_name_pattern>*
do
	cp $FILE/*.<file type> <path of destination folder>
done
```


Example,

```
#!/bin/bash
for FILE in Docking*  #Lets say folders arer like Docking1, Docking2, Docking3. It extracts only Folder starting with Docking. If we are in a directory with the Docking folders only we can we "*" only.
do
	cp $FILE/*.log Finallog
done
```
So Finallog will contain all the log files from all the docking folders.
