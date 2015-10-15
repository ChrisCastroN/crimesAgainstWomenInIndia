library(ggplot2)

plotCrime <- function(df, theState,theCrime){
    
    if(theState==""){
        theState <-"Assam"
    }
    if(theCrime==""){
        theCrime="RAPE"
    }
    print(theState)
    #print(theCrime)
    #print(dim(df))
    # Create a data frame for 
    r <- filter(df,state==theState,crime==theCrime)
    #print(head(r))
    r <- r[4:21]
    crm <- t(r)
    year <- as.matrix(c(2001:2018))
    
    crm <- cbind(year,crm)
    crimeRate <- as.data.frame(crm)
    #print(head(crimeRate))
    names(crimeRate) <- c("Year","Crimes")
    #qplot(Year,Crime,data=crimeRate,geom=c("point","smooth"),method="lm")
    title <- paste("Incidence of ",tolower(theCrime),"in ",theState)
    g <- ggplot(crimeRate, aes(Year,Crimes))
    g+geom_point() + geom_smooth(method="lm") + ylab(theCrime) +
        ggtitle(title)
       
    
}


plotMap <- function(df,theCrime="RAPE",theYear="X2015"){
    if(theYear==""){
        theYear<-"2001"
    }
    print(theYear)
    print(theCrime)
    r <- filter(df,crime==theCrime)
    r <- r[-36,]
    # Set the year for which the crime is required
    year <- paste("X",theYear)
    year <- str_replace_all(year," ","")
    print(year)
    a <-colnames(r)==year
    # Use which to get the column number for the selection
    crimeSet <- select(r,state,crime,which(a))
    
    crimeSet$state = as.character(r$state)
    crimeSet[crimeSet$state=="D&N Haveli",]$state = "Dadra and Nagar Haveli"
    crimeSet[crimeSet$state=="Daman & Diu",]$state = "Daman and Diu"
    crimeSet[crimeSet$state=="A&N Islands",]$state = "Andaman and Nicobar"
    crimeSet[crimeSet$state=="Jammu & Kashmir",]$state = "Jammu and Kashmir"
    crimeSet[crimeSet$state=="Delhi UT",]$state = "Delhi"
    crimeSet[crimeSet$state=="Odisha",]$state = "Orissa"
    crimeSet[crimeSet$state=="Uttarakhand",]$state = "Uttaranchal"
    print(dim(crimeSet))
    print(names(crimeSet))
    
    names(crimeSet) <- c("state","crime","yearlyCrimes")
    
    m= max(crimeSet$yearlyCrimes)
    n = min(crimeSet$yearlyCrimes)
    mid = (m+n)/2
    
    
    
    b <- head(arrange(crimeSet,desc(yearlyCrimes)),5)
    c <- paste(b$state,"(",b$yearlyCrimes,")")
    stateCrime <- str_replace_all(c," ","")
    
    labels <- data.frame(
        xc = c(90,90,90,90,90), 
        yc = c(7.0,5.6,4.2,2.8,1.4), 
        label = as.vector(stateCrime) 
        
    )
    print(c)
    title <- paste("Incidence of",tolower(theCrime),"in India in ",theYear)
    ggplot(data = crimeSet)  + 
        geom_map(data = crimeSet, aes(map_id = state, fill = yearlyCrimes), col="brown",  map = ind, ) + 
        expand_limits(x = ind$long, y = ind$lat) +        
        scale_fill_gradient2(low = "pink",                                                                           
                             mid = "red", midpoint = mid, high = "black", limits = c(n, m)) +
        ggtitle(title) +
        geom_text(aes(label="Top offenders",90,8.6))+
        geom_text(data = labels, aes(x = xc, y = yc, label = label))+
        geom_text(aes(label="Data source:https://data.gov.in",90,38,size=0.8))
    
    
}