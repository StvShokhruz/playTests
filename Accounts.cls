public class Accounts {

    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
    public void newMethod(){}
    
    public override void onBeforeInsert() {
        List<Account> newAccounts = new List<Account>();
        
        for (Account acct : (List<Account>) Records) {
            acct.Description = 'Domain classes rock!';
            newAccounts.add(acct);
        }
        
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        uow.registerNew(newAccounts);
    }
    
    public override void onBeforeUpdate(Map<Id,sObject> existingRecords) {
        String rock = 'Domain classes rock!';
        List<Account> updatedAccounts = new List<Account>();
        for(Account acc : (List<Account>) Records) {                  
            acc.AnnualRevenue = rock.getLevenshteinDistance(acc.Description);
            updatedAccounts.add(acc);
        }
       
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        uow.registerDirty(updatedAccounts);
    }
    
    public override void onApplyDefaults() {
        String rock = 'Domain classes rock!';
        List<Account> accountList = (List<Account>)Records;
        List<Account> updatedAccounts = new List<Account>();
        
        for (Account acct : accountList) {
            if (acct.Description != NULL) {
                acct.AnnualRevenue = rock.getLevenshteinDistance(acct.Description);
                updatedAccounts.add(acct);
            }
        }
        
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
        uow.registerDirty(updatedAccounts);
        uow.commitWork();
    }
}