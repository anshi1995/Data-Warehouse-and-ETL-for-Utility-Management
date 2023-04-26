-- public.accountdetails definition

CREATE TABLE public.accountdetails (
	accountid varchar(250) NOT NULL,
	bankname varchar(250) NULL,
	bankstreetaddress varchar(250) NULL,
	bankcity varchar(250) NULL,
	bankzip varchar(250) NULL,
	bankstatename varchar(50) NULL,
	bankstateshortname varchar(10) NULL,
	bankcountry varchar(50) NULL,
	paymenttype int4 NULL,
	ownerid int4 NULL,
	CONSTRAINT accountdetails_pkey PRIMARY KEY (accountid)
);

-- public.accountdetails foreign keys

ALTER TABLE public.accountdetails
ADD CONSTRAINT accountdetails_ownerid_fkey FOREIGN KEY (ownerid) REFERENCES public.accountowner(ownerid);

ALTER TABLE public.accountdetails
ADD CONSTRAINT accountdetails_paymenttype_fkey FOREIGN KEY (paymenttype) REFERENCES public.paymentmethod(paymentmethodid);

------------------------------------------------------------------------------------------

-- public.accountowner definition

CREATE TABLE public.accountowner (
	ownerid serial4 NOT NULL,
	ownername varchar(250) NULL,
	phone varchar(50) NULL,
	CONSTRAINT accountowner_pkey PRIMARY KEY (ownerid)
);

------------------------------------------------------------------------------------------

-- public.enterprise definition

CREATE TABLE public.enterprise (
	enterpriseid serial4 NOT NULL,
	enterprisetype varchar(15) NULL,
	typedescription varchar(250) NULL,
	CONSTRAINT enterprise_pkey PRIMARY KEY (enterpriseid)
);

------------------------------------------------------------------------------------------

-- public.facility definition

CREATE TABLE public.facility (
	facilityid serial4 NOT NULL,
	facilityname varchar(250) NULL,
	streetaddress varchar(250) NULL,
	city varchar(250) NULL,
	zip varchar(250) NULL,
	statename varchar(50) NULL,
	stateshortname varchar(10) NULL,
	country varchar(50) NULL,
	departmentid int4 NULL,
	CONSTRAINT facility_pkey PRIMARY KEY (facilityid)
);

------------------------------------------------------------------------------------------

-- public.paymentmethod definition

CREATE TABLE public.paymentmethod (
	paymentmethodid serial4 NOT NULL,
	paymentmethodname varchar(250) NULL,
	CONSTRAINT paymentmethod_pkey PRIMARY KEY (paymentmethodid)
);

------------------------------------------------------------------------------------------

-- public.providercategory definition

CREATE TABLE public.providercategory (
	categoryid serial4 NOT NULL,
	categoryname varchar(250) NULL,
	categorydesc varchar(250) NULL,
	CONSTRAINT providercategory_pkey PRIMARY KEY (categoryid)
);

------------------------------------------------------------------------------------------

-- public.utilitybills definition

CREATE TABLE public.utilitybills (
	electricbillid int4 NULL,
	invoicetypeid int4 NULL,
	invoicedate date NULL,
	fromdate date NULL,
	todate date NULL,
	usageperiod float8 NULL,
	deliverycost float8 NULL,
	supplycost float8 NULL,
	totalconsumption float8 NULL,
	demand float8 NULL,
	unitname varchar(250) NULL,
	facilityid int4 NULL,
	accountnumber varchar(2000) NULL
);

------------------------------------------------------------------------------------------

-- public.utilityproviders definition

CREATE TABLE public.utilityproviders (
	providerid serial4 NOT NULL,
	providername varchar(250) NULL,
	categoryid int4 NULL,
	enterpriseid int4 NULL,
	CONSTRAINT utilityproviders_pkey PRIMARY KEY (providerid)
);

-- public.utilityproviders foreign keys

ALTER TABLE public.utilityproviders
ADD CONSTRAINT utilityproviders_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.providercategory(categoryid);

ALTER TABLE public.utilityproviders
ADD CONSTRAINT utilityproviders_enterpriseid_fkey FOREIGN KEY (enterpriseid) REFERENCES public.enterprise(enterpriseid);

ALTER TABLE public.utilityproviders
ADD CONSTRAINT utilityproviders_enterpriseid_fkey1 FOREIGN KEY (enterpriseid) REFERENCES public.enterprise(enterpriseid);