
from PyPDF2 import PdfMerger
import os
#Create an instance of PdfFileMerger() class
merger = PdfMerger()

#Create a list with the file paths
pdf_files = ['1.pdf', '2.pdf','3.pdf']

#Iterate over the list of the file paths
for pdf_file in pdf_files:
    #Append PDF files
    merger.append(pdf_file)

#Write out the merged PDF file
merger.write("merged.pdf")
os.startfile("merged.pdf")

merger.close()