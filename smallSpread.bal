import ballerina/io;
import ballerina/regex;

public function main() returns error? 
{
    string|io:Error wheaterData = io:fileReadString("./weather.dat");
    
    string[] splitByLines = regex:split(check wheaterData, "\n");

    int smallestSpreadDay = -1;
    float smallestSpread = -1;
    int i = 0;

    foreach string lines in splitByLines 
    {
        // Refactor
        string lines2 = lines;
        lines2 = regex:replaceAll(lines2, "\\*", "");

        string[] splitBySpace = regex:split(lines2, "\\s+");
        if (splitBySpace.length() >= 3 && (i >= 1 && i <= 31)) 
        {
            int day = check int:fromString(splitBySpace[1]);
            
            float maxTemp = check float:fromString(splitBySpace[2]);
            
            float minTemp = check float:fromString(splitBySpace[3]);

            float tempSpread = maxTemp - minTemp;

            if (smallestSpreadDay == -1 || tempSpread < smallestSpread) 
            {
                smallestSpreadDay = day;
                smallestSpread = tempSpread;
            }
        }
        i = i + 1;        
    }

    io:println("The smallest spread day was: ", smallestSpreadDay, "\nWith a spread of: ", smallestSpread);
    return();
}