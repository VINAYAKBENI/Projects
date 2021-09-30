#include <fstream>
#include <conio.h>
#include <stdio.h>
#include <string>
#include <iomanip>
#include <iostream>
#include <windows.h>

using namespace std;
//***************************************************************
//                   CLASS USED IN PROJECT
//****************************************************************

class hospital
{
    char hid[6];
    char hname[20];
    char hloc[20];
    char hbed[5];

public:
    void create_hospital()
    {
        getchar();
        cout << "\nNEW HOSPITAL ENTRY...\n";
        cout << "\nEnter The hospital no.";
        gets(hid);
        cout << "\nEnter The Name of The Hospital ";
        gets(hname);
        cout << "\nEnter The Location's Name ";
        gets(hloc);
        cout << "\nEnter available no. of beds ";
        gets(hbed);
        cout << "\n\nHospital Created..";
    }

    void show_hospital()
    {
        cout << "Hospital no. : ";
        puts(hid);
        cout << "Hospital Name : ";
        puts(hname);
        cout << "Location Name : ";
        puts(hloc);
        cout << "available no. of beds ";
        puts(hbed);
    }

    void modify_hospital()
    {   getchar();
        cout << "\nHospital no. : " << hid;
        cout << "\nModify Hospital Name : ";
        gets(hname);
        cout << "\nModify Location's Name of Hospital : ";
        gets(hloc);
        cout << "\nModify available no. of beds ";
        gets(hbed);
    }

    char *rethid()
    {
        return hid;
    }

    char *rethname()
    {
        return hname;
    }

    char *rethloc()
    {
        return hloc;
    }

    char *rethbed()
    {
        return hbed;
    }

    void report()
    {
        cout << hid << setw(40) << hname << setw(30) << hloc << setw(30) << hbed << endl;
    }

}; //class ends here

//***************************************************************
//        global declaration for stream object, object
//****************************************************************

fstream fp, fp1;
hospital bk;

//***************************************************************
//        function to write in file
//****************************************************************

void write_hospital()
{
    char ch;
    fp.open("hospital.dat", ios::out | ios::app);
    do
    {

        bk.create_hospital();
        fp.write((char *)&bk, sizeof(hospital));
        cout << "\n\nDo you want to add more record..(y/n?)";
        cin >> ch;
    } while (ch == 'y' || ch == 'Y');
    fp.close();
}

//***************************************************************
//        function to read specific record from file
//****************************************************************

void display_spb()
{
    char x;
    cout << "SEARCH BY \n1 HID \n2 HOSPITAL NAME \n3 LOCATION \n4 AVAILABLE NO OF BEDS \nPRESS(1-4)";
    cin >> x;
    char n[6];
    if (x < '4' && x > '0')
    {
        cout << "\n\n\tPlease Enter The hospital searching parameter (hid/hospital name/location) ";
        cin >> n;
    }
    cout << "\nHOSPITAL DETAILS\n";
    int flag = 0;
    fp.open("hospital.dat", ios::in);
    while (fp.read((char *)&bk, sizeof(hospital)))
    {
        switch (x)
        {
        case '1':
            if (strcmpi(bk.rethid(), n) == 0)
            {
                bk.show_hospital();
                flag = 1;
            }
            break;

        case '2':
            if (strcmpi(bk.rethname(), n) == 0)
            {
                bk.show_hospital();
                flag = 1;
            }
            break;

        case '3':
            if (strcmpi(bk.rethloc(), n) == 0)
            {
                bk.show_hospital();
                flag = 1;
            }
            break;
        case '4':
            if (strcmpi(bk.rethbed(), "0") != 0)
            {
                bk.show_hospital();
                flag = 1;
            }
            break;
        }
    }

    fp.close();
    if (flag == 0)
        cout << "\n\nHospital does not exist";
    getch();
}

//***************************************************************
//        function to modify record of file
//****************************************************************

void modify_hospital()
{
    char n[15];
    int found = 0;

    cout << "\n\n\tMODIFY HOSPITAL RECORD.... ";
    cout << "\n\n\tEnter The hospital no. of The hospital";
    cin >> n;
    fp.open("hospital.dat", ios::in | ios::out);
    while (fp.read((char *)&bk, sizeof(hospital)) && found == 0)
    {
        if (strcmpi(bk.rethid(), n) == 0)
        {
            bk.show_hospital();
            cout << "\nEnter The New Details of hospital" << endl;
            bk.modify_hospital();
            int pos = -1 * sizeof(bk);
            fp.seekp(pos, ios::cur);
            fp.write((char *)&bk, sizeof(hospital));
            cout << "\n\n\t Record Updated";
            found = 1;
        }
    }

    fp.close();
    if (found == 0)
        cout << "\n\n Record Not Found ";
    getch();
}

//***************************************************************
//        function to delete record of file
//****************************************************************

void delete_hospital()
{
    char n[15];

    cout << "\n\n\n\tDELETE HOSPITAL ...";
    cout << "\n\nEnter The Hospital no. of the Hospital You Want To Delete : ";
    cin >> n;
    fp.open("hospital.dat", ios::in | ios::out);
    fstream fp2;
    fp2.open("Temp.dat", ios::out);
    fp.seekg(0, ios::beg);
    while (fp.read((char *)&bk, sizeof(hospital)))
    {
        if (strcmpi(bk.rethid(), n) != 0)
        {
            fp2.write((char *)&bk, sizeof(hospital));
        }
    }

    fp2.close();
    fp.close();
    remove("hospital.dat");
    rename("Temp.dat", "hospital.dat");
    cout << "\n\n\tRecord Deleted ..";
    getch();
}

//***************************************************************
//        function to display Hospitals list
//****************************************************************

void display_allb()
{

    fp.open("hospital.dat", ios::in);
    if (!fp)
    {
        cout << "ERROR!!! FILE COULD NOT BE OPEN ";
        getch();
        return;
    }
    cout << "\n\n\t\tHospital LIST\n\n";
    cout << "===================================================================================================================================\n";
    cout << "Hospital Number" << setw(30) << "Hospital Name" << setw(30) << "Location " << setw(30) << "No of available beds"
         << "\n";
    cout << "===================================================================================================================================\n";

    while (fp.read((char *)&bk, sizeof(hospital)))
    {
        bk.report();
    }
    fp.close();

}

void gotoxy(short x, short y)
{
    COORD c = {x, y};
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), c);
}

//***************************************************************
//        INTRODUCTION FUNCTION
//****************************************************************

void intro()
{
    system("cls");
    cout << "\nMADE BY : SAMBHAV JAIN" << setw(20) << "VINAYAK BENI";
    cout << "\nROLL NO : 2K20/A12/04" << setw(20) << "2K20/A12/15";
    gotoxy(38, 7);
    cout << "COVID HELP DESK";
    gotoxy(36, 8);
    cout << "HOW CAN WE HELP YOU ?";
    
}

//***************************************************************
//        THE MAIN FUNCTION OF PROGRAM
//****************************************************************

int main()
{
    int i = 0, j = 0,loo=0;
    int pass;
    while (i == 0)
    {
        intro();
        cout<<endl;
        cout << " MAIN MENU" << endl;
        cout << "1. INFORMATION REGARDING COVID  " << endl;
        cout << "2. COVID HELPLINE NUMBERS " << endl;
        cout << "3. SEARCH FOR HOSPITAL " << endl;
        cout << "4. ADMINISTRATOR MENU " << endl;
        cout<<"ENTER YOuR CHOICE"<<endl;
        cin>>j;
        switch (j)
        {
        case 1:
        {
            cout << "\nPRECAUTIONS \n" << endl;
            cout <<" To prevent the spread of COVID-19: \n";
                cout<<" clean your hands often.Use soap and water,or an alcohol - based hand rub. \n";
                cout<<" Maintain a safe distance from anyone who is coughing or sneezing. \n";
                cout<<" Wear a mask when physical distancing is not possible. \n";
                cout<<" Don’t touch your eyes, nose or mouth. \n";
                cout<<" Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze. \n";
                cout<<" Stay home if you feel unwell. \n";
                cout<<" If you have a fever, cough and difficulty breathing, seek medical attention. \n "<<endl;
                                                                                                                                                                                                                                                                                                                                                                                                            cout
                                                                                                                                                                                                                                                                                                                                                                                                            << "SYMPTOMS " << endl;
            cout << "Most common symptoms: \n";
            cout << "fever \n";
                         cout<<"dry cough \n";
                         cout<<"tiredness \n";
                         cout<<"Less common symptoms : \n";
                         cout<<"aches andpains \n";
                         cout<<"sore throat \n";
                         cout<<"diarrhoea \n";
                         cout<<"conjunctivitis \n";
                         cout<<"headache \n";
                         cout<<"loss of taste or smell \n ";
                         cout<<"a rash on skin,or discolouration of fingers or toes \n "<< endl;
            cout<<"ADVICE FOR PUBLIC : MYTHBUSTERS "<<endl;
            cout<<"FACT 1 : Hand sanitizers can be used often"<<endl;
            cout<<"FACT 2 : Alcohol-based sanitizers are safe for everyone to use"<<endl;
            cout<<"FACT 3 : Alcohol-based sanitizers can be used in religions where alcohol is prohibited"<<endl;
            cout<<"FACT 4 : It is safer to frequently clean your hands and not wear gloves"<<endl;
            cout<<"FACT 5 : Touching a communal bottle of alcohol-based sanitizer will not infect you"<<endl;
            cout<<"FACT 6 : An alcohol-based handrub is listed as a WHO essential medicine\n"<<endl;
            break ;
        }

        case 2:{
            cout<<"\nCOVID HELPLINE NUMBERS  \n"<<endl;
            cout<<"CORONA (COVID 19) HELPLINE:  011-23978046 OR 1075\n";
            cout<<"DELHI COVID HELPLINE : 1031\n";
            cout<<"COVID CONTROL ROOM : 011-22391014,22302441,22304568 ,22300012\n";
            cout<<"COVID HELPLINE FOR POSITIVE PAITENTS : 1800-111-747\n"<<endl;
            break;
        }
        case 3:{
            int choice;
            cout << "\n\n\t1.DISPLAY ALL HOSPITALS  ";
            cout << "\n\n\t2.DISPLAY SPECIFIC HOSPITAL ";
            cout<<"\n\n \t ENTER YOUR CHOICE ";
            cin>>choice;
            switch(choice){
                case 1:{
                     display_allb();
                     break;   
                }
                case 2:{
                    display_spb();
                    break; 
                }
                default:{
                    cout<<"ERROR WRONG INPUT "<<endl;
                    break;
                }
            }
            break;
           
        }
        case 4:{
            cout<<"ENTER THE PASSWORD : "<<endl;
            cin>>pass;
            if(pass==12321){
            int ch2;
        cout << "\n\n\n\tADMINISTRATOR MENU";
        cout << "\n\n\t1.CREATE HOSPITAL ";
        cout << "\n\n\t2.DISPLAY ALL HOSPITALS ";
        cout << "\n\n\t3.DISPLAY SPECIFIC HOSPITAL ";
        cout << "\n\n\t4.MODIFY HOSPITAL ";
        cout << "\n\n\t5.DELETE HOSPITAL ";
        cout << "\n\n\tPlease Enter Your Choice (1-5) ";
        cin >> ch2;
        switch (ch2)
        {

        case 1:
            write_hospital();
            break;
        case 2:
            display_allb();
            break;
        case 3:
        {
            display_spb();
            break;
        }
        case 4:
            modify_hospital();
            break;
        case 5:
            delete_hospital();
            break;
        default:
            cout << "\a";
        }

            }
            else{
                cout<<"ERROR WRONG PASSWORD "<<endl;
            }
        break;
        }
        default:{
            cout<<"ERROR WRONG INPUT "<<endl;
        }
        }
    cout<<"DO YOU WANT TO RETURN TO MAIN MENU YES->1 / NO->2 : "<<endl;
    cin>>loo;
    if(loo==1){
        i=0;
    }
    else{
        cout<<"THANK YOU "<<endl;
        i=1;
    }
        }
    return 0;
}

//***************************************************************
//                END OF PROJECT
//***************************************************************
