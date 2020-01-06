import {Injectable} from '@angular/core'

@Injectable()
export class Globals{
    showTabs : boolean = false;
    city : string;
    state : string;
    lat : string;
    long : string;
    stateName : string;
    sealUrl :string;
    myStorage = window.localStorage;
    
    

   getStateName( abb:string):string{
        if(abb == "AL"){
            return "Alabama";
        }
        else if(abb == "AK"){
            return "Alaska";
        }
        else if(abb == "AZ"){
            return "Arizona";
        }
        else if(abb == "AR"){
            return "Arkansas";
        }
        else if(abb == "CA"){
            return "California";
        }
        else if(abb == "CO"){
            return "Colorado";
        }
        else if(abb == "CT"){
            return "Connecticut";
        }
        else if(abb == "DE"){
            return "Delaware";
        }
        else if(abb == "DC"){
            return "District of Columbia";
        }
        else if(abb == "FL"){
            return "Florida";
        }
        else if(abb == "GA"){
            return "Georgia";
        }
        else if(abb == "HI"){
            return "Hawaii";
        }
        else if(abb == "ID"){
            return "Idaho";
        }
        else if(abb == "IL"){
            return "Illinois";
        }
        else if(abb == "IN"){
            return "Indiana";
        }
        else if(abb == "IA"){
            return "Iowa";
        }
        else if(abb == "KS"){
            return "Kansas";
        }
        else if(abb == "KY"){
            return "Kentucky";
        }
        else if(abb == "LA"){
            return "Louisiana";
        }
        else if(abb == "ME"){
            return "Maine";
        }
        else if(abb == "MD"){
            return "Maryland";
        }
        else if(abb == "MA"){
            return "Massachusetts";
        }
        else if(abb == "MI"){
            return "Michigan";
        }
        else if(abb == "MN"){
            return "Minnesota";
        }
        else if(abb == "MS"){
            return "Mississippi";
        }
        else if(abb == "MO"){
            return "Missouri";
        }
        else if(abb == "MT"){
            return "Montana";
        }
        else if(abb == "NE"){
            return "Nebraska";
        }
        else if(abb == "NV"){
            return "Nevada";
        }
        else if(abb == "NH"){
            return "New Hampshire";
        }
        else if(abb == "NJ"){
            return "New Jersey";
        }
        else if(abb == "NM"){
            return "New Mexico";
        }
        else if(abb == "NY"){
            return "New York";
        }
        else if(abb == "NC"){
            return "North Carolina";
        }
        else if(abb == "ND"){
            return "North Dakota";
        }
        else if(abb == "OH"){
            return "Ohio";
        }
        else if(abb == "OK"){
            return "Oklahoma";
        }
        else if(abb == "OR"){
            return "Oregon";
        }
        else if(abb == "PA"){
            return "Pennsylvania";
        }
        else if(abb == "RI"){
            return "Rhode Island";
        }
        else if(abb == "SC"){
            return "South Carolina";
        }
        else if(abb == "SD"){
            return "South Dakota";
        }
        else if(abb == "TN"){
            return "Tennessee";
        }
        else if(abb == "TX"){
            return "Texas";
        }
        else if(abb == "UT"){
            return "Utah";
        }
        else if(abb == "VT"){
            return "Vermont";
        }
        else if(abb == "VA"){
            return "Virginia";
        }
        else if(abb == "WA"){
            return "Washington";
        }
        else if(abb == "WV"){
            return "West Virginia";
        }
        else if(abb == "WI"){
            return "Wisconsin";
        }
        else if(abb == "WY"){
            return "Wyoming";
        }

   }
}