import ballerina/io;
import ballerina/regex;

public function main() returns error?
{
    string footDat = check io:fileReadString("./football.dat");
    string[] footLines = regex:split(footDat, "\n");
    int smallestFA = 1000;
    string teamFA = "";
    int i = 0;

    foreach string lines in footLines 
    {
        string[] splitBySpace = regex:split(lines, "\\s+");
        
        int smallest = 0;
        string team = "";
        if ((i >= 1 && i <= 17) || (i >= 19 && i <= 21)) 
        {
            int goalFor = check int:fromString(splitBySpace[7]);
            int goalAgainst = check int:fromString(splitBySpace[9]);
            smallest = goalFor - goalAgainst;
            team = splitBySpace[2];
            if ((goalFor - goalAgainst) < 0) 
            {
                smallest = smallest * (-1);
            }

            if (smallestFA > smallest) 
            {
                smallestFA = smallest;
                teamFA = team;                
            }
        }
        i = i + 1;
        
    }

    io:print("The team with the smallest difference is: ", teamFA, " with a difference of: ", smallestFA);
}