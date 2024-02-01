//Entity with enum
entity.Property(e => e.intApplicationStatus)
.HasConversion(new EnumToNumberConverter<ApplicationStatus, int>());


//Payment Request for edit
{
  "applicationNumber": "E-00001",
  "personalID": 1,
  "assureType": 1,
  "paymentType": "OnlinePayment",
  "renewalMode": "cheque",
}


//datetime handling
(Guard.IsNotNull(item.FirstDiagnosis!))?SharedFunction.ParseDate(item.FirstDiagnosis!):null )!,

