@istest
public class TestDataFactory {
    
    public static Account createAccount(String name, boolean doInsert){
        Account acc = new Account();
        acc.Name = name;
        if(doInsert){
            insert acc;
        }
        return acc;
    }
    
   public static Opportunity createOpportunity(String name,String accId,Date closeDate,String stageName, boolean doInsert ){
        Opportunity opp = new Opportunity();
        opp.Name = name;
        opp.AccountId= accId;
        opp.CloseDate = closeDate;
        opp.StageName = stageName;
        if(doInsert){
            insert opp;
        }
        return opp;
       
    }
    
    public static Lead createLead(String firstname, String lastname, String status,String email, boolean doInsert){
        Lead lead = new Lead();
        lead.FirstName = firstname;
        lead.LastName = lastname;
        lead.Status = 'New';
        lead.Email = email;
        if(doInsert){
            insert lead;
        }
        return lead;
    }
    
    public static Project__c createProject(String name, boolean doInsert){
        Project__c project = new Project__c();
        project.Name = name;
        if(doInsert){
            insert project;
        }
        return project;
    }
    
    
    public static Project_Unit_Type__c createProjectUnitType(String name, String projectId, boolean doInsert){
        Project_Unit_Type__c unitType = new Project_Unit_Type__c();
        unitType.Name = name;
        unitType.Project__c = projectId;
        if(doInsert){
            insert unitType;
        }
        return unitType;
    }
    
    public static Unit__c createUnit(String name, String unitTypeId, boolean doInsert){
        Unit__c unit = new Unit__c();
        unit.Name = name;
        unit.Project_Unit_Type__c = unitTypeId;
        if(doInsert){
            insert unit;
        }
        return unit;
    }
    
    public static Unit_Preference__c createUnitPreference( String unitId,String opportunityId, boolean doInsert){
        Unit_Preference__c unitPref = new Unit_Preference__c();
        unitPref.Unit__c = unitId;
        unitPref.Opportunity__c = opportunityId;
        if(doInsert){
            insert unitPref;
        }
        return unitPref;
    }

}