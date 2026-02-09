#include<stdio.h>

/* Multilevel Feeedback Queue with Q1 following RR with time quantum 10, Q2 following RR with time quantum 30 and Q3 following FCFS*/

struct process
{
    char name;
    int AT,BT,WT,TAT,RT,CT;
}Q1[10],Q2[10],Q3[10];/*Three queues*/

int n = 4; // Hardcoded number of processes

void sortByArrival()
{
    struct process temp;
    int i,j;
    for(i=0;i<n;i++)
    {
        for(j=i+1;j<n;j++)
        {
            if(Q1[i].AT>Q1[j].AT)
            {
                temp=Q1[i];
                Q1[i]=Q1[j];
                Q1[j]=temp;
            }
        }
    }
}

int main()
{
    int i,j,k=0,r=0,time=0,tq1=10,tq2=30,flag=0;
    
    int arrival_times[] = {0, 3, 4, 9};
    int burst_times[] = {60, 30, 40, 10};
    char names[] = {'1', '2', '3', '4'};

    for(i=0; i<n; i++)
    {
        Q1[i].name = names[i];
        Q1[i].AT = arrival_times[i];
        Q1[i].BT = burst_times[i];
        Q1[i].RT = Q1[i].BT; /*save burst time in remaining time*/
    }

    sortByArrival();
    time=Q1[0].AT;

    printf("Process in first queue following RR with time quantum = 10");
    printf("\nProcess\t\tRT\t\tWT\t\tTAT\t\t");
    for(i=0;i<n;i++)
    {
        if(Q1[i].RT<=tq1)
        {
            time+=Q1[i].RT;/*from arrival time of first process to completion of this process*/
            Q1[i].RT=0;
            Q1[i].WT=time-Q1[i].AT-Q1[i].BT;/*amount of time process has been waiting in the first queue*/
            Q1[i].TAT=time-Q1[i].AT;/*amount of time to execute the process*/
            printf("\n%c\t\t%d\t\t%d\t\t%d",Q1[i].name,Q1[i].BT,Q1[i].WT,Q1[i].TAT);
        }
        else/*process moves to queue 2 with qt=8*/
        {
            Q2[k].WT=time;
            time+=tq1;
            Q1[i].RT-=tq1;
            Q2[k].BT=Q1[i].RT;
            Q2[k].RT=Q2[k].BT;
            Q2[k].name=Q1[i].name;
            Q2[k].AT=Q1[i].AT; // Needed for TAT calculation in later queues
            k=k+1;
            flag=1;
        }
    }

    if(flag==1)
    {
        printf("\nProcess in second queue following RR with time quantum = 30");
        printf("\nProcess\t\tRT\t\tWT\t\tTAT\t\t");
    }
    
    for(i=0;i<k;i++)
    {
        if(Q2[i].RT<=tq2)
        {
            time+=Q2[i].RT;/*from arrival time of first process +BT of this process*/
            Q2[i].RT=0;
            Q2[i].WT=time-tq1-Q2[i].BT-Q2[i].AT;/*amount of time process has been waiting in ready queue*/
            Q2[i].TAT=time-Q2[i].AT;/*amount of time to execute the process*/
            printf("\n%c\t\t%d\t\t%d\t\t%d",Q2[i].name,Q2[i].BT,Q2[i].WT,Q2[i].TAT);
        }
        else/*process moves to queue 3 with FCFS*/
        {
            Q3[r].AT=Q2[i].AT;
            time+=tq2;
            Q2[i].RT-=tq2;
            Q3[r].BT=Q2[i].RT;
            Q3[r].RT=Q3[r].BT;
            Q3[r].name=Q2[i].name;
            r=r+1;
            flag=2;
        }
    }

    if(flag==2)
    {
        printf("\nProcess in third queue following FCFS ");
    }

    for(i=0;i<r;i++)
    {
        if(i==0)
            Q3[i].CT=time+Q3[i].BT; 
        else
            Q3[i].CT=Q3[i-1].CT+Q3[i].BT;
    }

    for(i=0;i<r;i++)
    {
        Q3[i].TAT=Q3[i].CT-Q3[i].AT;
        // Total BT is remaining BT + 5 (Q1) + 8 (Q2)
        Q3[i].WT=Q3[i].TAT-(Q3[i].BT+tq1+tq2);
        printf("\n%c\t\t%d\t\t%d\t\t%d\t\t",Q3[i].name,Q3[i].BT,Q3[i].WT,Q3[i].TAT);
    }
    printf("\n");
    return 0;
}
