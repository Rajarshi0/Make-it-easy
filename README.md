# Make-Docking-easy
I saw many of my friends to handle docking result files to analyze. They were handling thousands of file individually. Lets say there are 100000 files, it would be hectic to do it manually. So, I wrote simple cmd and Linux command to make their work easy. 


## Extracting the log files from many other file  types

Let's say, a folder contains many files with different file types and we need files from a single file type so simple command to that will be copying it to other folder:

**Sample code:**
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

**Sample code:**

```
#!/bin/bash
for FILE in <Folder_name_pattern>*
do
	cp $FILE/*.<file type> <path of destination folder>
done
```


Example,

Lets say folders arer like Docking1, Docking2, Docking3. It extracts only Folder starting with Docking. If we are in a directory with the Docking folders only we can we "*" only.

```
#!/bin/bash
for FILE in Docking*  
do
	cp $FILE/*.log Finallog
done
```
So, the folder "Finallog" will contain all the log files from all the docking folders.


## Extracting important parts from the extracted log files

Let's say we have all the log files of docking result in one folder and we want to extract a portion of it. 

Example of a log file:
```
#################################################################
# If you used AutoDock Vina in your work, please cite:          #
#                                                               #
# O. Trott, A. J. Olson,                                        #
# AutoDock Vina: improving the speed and accuracy of docking    #
# with a new scoring function, efficient optimization and       #
# multithreading, Journal of Computational Chemistry 31 (2010)  #
# 455-461                                                       #
#                                                               #
# DOI 10.1002/jcc.21334                                         #
#                                                               #
# Please see http://vina.scripps.edu for more information.      #
#################################################################

WARNING: The search space volume > 27000 Angstrom^3 (See FAQ)
Output will be ligand11000_out.pdbqt
Detected 8 CPUs
Reading input ... done.
Setting up the scoring function ... done.
Analyzing the binding site ... done.
Using random seed: 1538898848
Performing search ... done.
Refining results ... done.

mode |   affinity | dist from best mode
     | (kcal/mol) | rmsd l.b.| rmsd u.b.
-----+------------+----------+----------
   1         -8.6      0.000      0.000            
   2         -8.3      2.318      3.812
   3         -8.3      1.655      2.143
   4         -8.2      1.638      2.179
   5         -8.2      2.681      8.573
   6         -7.9     33.263     37.256
   7         -7.6      5.446      7.190
   8         -7.4      7.919     11.675
   9         -7.3     33.294     36.997
Writing output ... done.
```

And let us consider we want to extract this line of information:

```
mode |   affinity | dist from best mode
     | (kcal/mol) | rmsd l.b.| rmsd u.b.
-----+------------+----------+----------
   1         -8.6      0.000      0.000       #This first line of information is needed for every log file      
   2         -8.3      2.318      3.812
   3         -8.3      1.655      2.143
   4         -8.2      1.638      2.179
   5         -8.2      2.681      8.573
   6         -7.9     33.263     37.256
   7         -7.6      5.446      7.190
   8         -7.4      7.919     11.675
   9         -7.3     33.294     36.997
Writing output ... done.
```

There are number of ways to do it like using sed or grep command. Even we can use haid and tails combined to get the specific line
For this we can use a simple method as in docking we will find that this first line will always contain a value of '0.000', so we can use it as a matching pattern for this first line only. We can store the value in csv format.

**Sample code:**
```
#!/bin/bash
for FILE in *.<file type>
do
	grep -H '<matching pattern>' $FILE >> <path to file>
done
```

Some extra information: 

1. The '-H' will extract the file name and include in the result. Sometimes it is needed for identification of the ligand.
2. '>>' it is used to append the result. If you use '>' it will everytime create a new file. But, we need all the result at a single file, So, we need to append the result.


Example,

```
#!/bin/bash
for FILE in *.log
do
	grep -H '0.000' $FILE >> ../draft.csv
done
```

I hope this helps. Though little modification of codes might be needed according to file types or path of file or the text to be extracted. 

If any problem is faced please do let me know. 

Thank you. 
Have a great day!!!
