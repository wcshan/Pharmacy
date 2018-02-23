create database Pharmacy;

create table Addresses(
addressId varchar(10) primary key not null,
line1Number varchar(10) not null,
line2Street varchar(50) not null,
line3Area varchar(50) not null,
city varchar(50) not null,
zipPostCode int not null,
stateProvinceCountry varchar(50) not null,
);

create table Customers(
customerId varchar(10) primary key not null,
addressId varchar(10) not null,
customerName varchar(100) not null,
dateBecomeCustomer varchar(25) not null,
creditCardNo varchar(20) not null,
cardExpiryDate varchar(10) not null,
constraint fkAddressId foreign key (addressId) references Addresses (addressId)
);

create table Physicians(
physicianId varchar(10) primary key not null,
addressId varchar(10) not null,
physicianName varchar(100) not null,
constraint fkPhyAddressId foreign key (addressId) references Addresses (addressId)
);

create table DrugCompanies(
companyId varchar(10) primary key not null,
companyName varchar(100) not null
);

create table DrugsAndMedication(
drugId varchar(10) primary key not null,
drugCompanyId varchar(10) not null,
drugName varchar(100) not null,
drugCost float not null,
drugAvailableDate varchar(12) not null,
drugDescription varchar(300),
genericEquivalentDrugId varchar(10)
constraint fkCompanyId foreign key (drugCompanyId) references DrugCompanies (companyId)
);

create table PaymentMethods(
paymentMethodCode varchar(10) primary key not null,
paymentMethod varchar(15) not null
);

create table PrescriptionStatus(
prescriptionStatuscode varchar(10) primary key not null,
statusDescription varchar(50) not null
);

create table Prescriptions(
prescriptionId varchar(10) primary key not null,
customerId varchar(10) not null,
physicianId varchar(10) not null,
statusCode varchar(10) not null,
paymentMethodCode varchar(10) not null,
issuedDate varchar(12) not null,
filledDate varchar(12) not null
constraint fkPreCustomerId foreign key (customerId) references Customers (customerId),
constraint fkPrePhysicianId foreign key (physicianId) references Physicians (physicianId),
constraint fkPreStatusCode foreign key (statusCode) references PrescriptionStatus (prescriptionStatuscode),
constraint fkPrePaymentMethodCode foreign key (paymentMethodCode) references PaymentMethods (paymentMethodCode)
);

create table PrescriptionItems(
prescriptionId varchar(10) not null,
drugId varchar(10) not null,
prescriptionQuantity int not null,
instructions varchar(100) not null,
primary key (prescriptionId, drugId),
constraint fkPrescriptionId foreign key (prescriptionId) references Prescriptions (prescriptionId),
constraint fkDrugId foreign key (drugId) references DrugsAndMedication (drugId)
);

