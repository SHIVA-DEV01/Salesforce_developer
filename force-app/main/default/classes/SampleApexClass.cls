public with sharing class SampleApexClass {
    public String[] dropdownOptions { get; set; }
    public String selectedOption { get; set; }
    public String accCode { get; set; }
    public String startDate { get; set; }
    public String endDate { get; set; }

    public SampleApexClass() {
        dropdownOptions = new String[] {'Select Customer'}; // Default option
        // Populate dropdownOptions with actual customer names
        List<Account> accounts = [SELECT Name FROM Account ORDER BY Name];
        for (Account acc : accounts) {
            dropdownOptions.add(acc.Name);
        }
    }

    public void fetchAccountNumber() {
        if (selectedOption != null && !selectedOption.equals('Select Customer')) {
            Account account = [SELECT AccountNumber FROM Account WHERE Name = :selectedOption LIMIT 1];
            accCode = account.AccountNumber;
        } else {
            accCode = '';
        }
    }

    public PageReference redirectToExternalPage() {
        String url = '/external-page-url'; // Replace with the actual URL
        url += '?acccode=' + EncodingUtil.urlEncode(accCode, 'UTF-8');
        url += '&sdate=' + EncodingUtil.urlEncode(startDate, 'UTF-8');
        url += '&edate=' + EncodingUtil.urlEncode(endDate, 'UTF-8');
        return new PageReference(url);
    }
}