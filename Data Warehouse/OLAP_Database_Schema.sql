/*
------------------------------------ SEQUENCES ------------------------------------
*/

-- public.states_statekey_seq definition

CREATE SEQUENCE public.states_state_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.city_citykey_seq definition

CREATE SEQUENCE public.city_citykey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
	
-- public.department_departmentkey_seq definition

CREATE SEQUENCE public.department_departmentkey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.facility_facilitykey_seq definition

CREATE SEQUENCE public.facility_facilitykey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.providercategory_providercategorykey_seq definition

CREATE SEQUENCE public.providercategory_providercategorykey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.enterprise_enterprisekey_seq definition

CREATE SEQUENCE public.enterprise_enterprisekey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.utilityprovider_utilityproviderkey_seq definition

CREATE SEQUENCE public.utilityprovider_utilityproviderkey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.payment_paymentkey_seq definition

CREATE SEQUENCE public.payment_paymentkey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- public.dates_datekey_seq definition

CREATE SEQUENCE public.dates_datekey_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;


/*
---------------------------------------- TABLES ----------------------------------------
*/

-- public.states definition

CREATE TABLE public.states (
	statekey int4 NOT NULL DEFAULT nextval('states_statekey_seq'::regclass),
	statename varchar(50) NULL,
	statenameshort varchar(10) NULL,
	country varchar(20) NULL,
	CONSTRAINT states_pkey PRIMARY KEY (statekey)
);

------------------------------------------------------------------------------------------

-- public.city definition

CREATE TABLE public.city (
	citykey int4 NOT NULL DEFAULT nextval('city_citykey_seq'::regclass),
	city varchar(50) NULL,
	statekey int4 NULL,
	CONSTRAINT city_pkey PRIMARY KEY (citykey)
);


-- public.city foreign keys

ALTER TABLE public.city
ADD CONSTRAINT city_statekey_fkey FOREIGN KEY (statekey) REFERENCES public.states(statekey);

------------------------------------------------------------------------------------------

-- public.department definition

CREATE TABLE public.department (
	departmentkey int4 NOT NULL DEFAULT nextval('department_departmentkey_seq'::regclass),
	departmentname varchar(250) NULL,
	departmentshortname varchar(250) NULL,
	departmentid int4 NOT NULL,
	departmentdescription varchar(64) NULL,
	CONSTRAINT department_pkey PRIMARY KEY (departmentkey)
);

------------------------------------------------------------------------------------------

-- public.facility definition

CREATE TABLE public.facility (
	facilitykey int4 NOT NULL DEFAULT nextval('facility_facilitykey_seq'::regclass),
	facilityname varchar(250) NULL,
	facilityid int4 NULL,
	streetaddress varchar(250) NULL,
	postalcode varchar(20) NULL,
	departmentkey int4 NULL,
	citykey int4 NULL,
	CONSTRAINT facility_pkey PRIMARY KEY (facilitykey)
);


-- public.facility foreign keys

ALTER TABLE public.facility
ADD CONSTRAINT facility_citykey_fkey FOREIGN KEY (citykey) REFERENCES public.city(citykey);

ALTER TABLE public.facility
ADD CONSTRAINT facility_departmentkey_fkey FOREIGN KEY (departmentkey) REFERENCES public.department(departmentkey);

------------------------------------------------------------------------------------------

-- public.providercategory definition

CREATE TABLE public.providercategory (
	providercategorykey int4 NOT NULL DEFAULT nextval('providercategory_providercategorykey_seq'::regclass),
	providercategoryid int4 NOT NULL,
	providercategoryname varchar(250) NULL,
	providercategorydescription varchar(1000) NULL,
	CONSTRAINT providercategory_pkey PRIMARY KEY (providercategorykey)
);

------------------------------------------------------------------------------------------

-- public.enterprise definition

CREATE TABLE public.enterprise (
	enterprisekey serial4 NOT NULL DEFAULT nextval('enterprise_enterprisekey_seq'::regclass),
	enterprisetypename varchar(250) NULL,
	enterprisedescription varchar(1000) NULL,
	enterpriseid int4 NOT NULL,
	CONSTRAINT enterprise_pkey PRIMARY KEY (enterprisekey)
);

------------------------------------------------------------------------------------------

-- public.utilityprovider definition

CREATE TABLE public.utilityprovider (
	utilityproviderkey int4 NOT NULL DEFAULT nextval('utilityprovider_utilityproviderkey_seq'::regclass),
	providername varchar(50) NULL,
	description varchar(250) NULL,
	streetaddress varchar(100) NULL,
	postalcode int4 NULL,
	citykey int4 NULL,
	enterprisekey int4 NOT NULL,
	providercategorykey int4 NOT NULL,
	providerid int4 NOT NULL,
	CONSTRAINT utilityprovider_pkey PRIMARY KEY (utilityproviderkey)
);

-- public.utilityprovider foreign keys

ALTER TABLE public.utilityprovider
ADD CONSTRAINT utilityprovider_enterprisekey_fkey FOREIGN KEY (enterprisekey) REFERENCES public.enterprise(enterprisekey);

ALTER TABLE public.utilityprovider
ADD CONSTRAINT utilityprovider_providercategorykey_fkey FOREIGN KEY (providercategorykey) REFERENCES public.providercategory(providercategorykey);

------------------------------------------------------------------------------------------

-- public.payment definition

CREATE TABLE public.payment (
	paymentkey int4 NOT NULL DEFAULT nextval('payment_paymentkey_seq'::regclass),
	paymentmethod varchar(250) NULL,
	accountownername varchar(50) NULL,
	bankname varchar(250) NULL,
	postalcode int4 NULL,
	city int4 NULL,
	accountid int4 NULL,
	CONSTRAINT payment_pkey PRIMARY KEY (paymentkey)
);

------------------------------------------------------------------------------------------

-- public.dates definition

CREATE TABLE public.dates (
	datekey int4 NOT NULL DEFAULT nextval('dates_datekey_seq'::regclass),
	actualdate date NULL,
	dayoftheweek int4 NULL,
	weekofmonth int4 NULL,
	weekofyear int4 NULL,
	monthfullname varchar(20) NOT NULL,
	monthshortname varchar(5) NULL,
	quarternumber int4 NULL,
	quartername varchar(5) NULL,
	yearofdate int4 NULL,
	leapyearflag varchar(5) NULL,
	monthnumber int4 NULL,
	CONSTRAINT dates_pkey PRIMARY KEY (datekey)
);

------------------------------------------------------------------------------------------

-- public.bills definition

CREATE TABLE public.bills (
	utilityproviderkey int4 NOT NULL,
	paymentkey int4 NOT NULL,
	facilitykey int4 NOT NULL,
	fromdatekey int4 NOT NULL,
	todatekey int4 NOT NULL,
	billamount float8 NULL,
	unitprice float8 NULL,
	deliverycost float8 NULL,
	supplycost float8 NULL,
	usageperiod float8 NULL,
	CONSTRAINT bills_pkey PRIMARY KEY (utilityproviderkey, paymentkey, facilitykey, fromdatekey, todatekey)
);

-- public.bills foreign keys

ALTER TABLE public.bills
ADD CONSTRAINT bills_utilityproviderkey_fkey FOREIGN KEY (utilityproviderkey) REFERENCES public.utilityprovider(utilityproviderkey);

ALTER TABLE public.bills
ADD CONSTRAINT bills_paymentkey_fkey FOREIGN KEY (paymentkey) REFERENCES public.payment(paymentkey);

ALTER TABLE public.bills
ADD CONSTRAINT bills_facilitykey_fkey FOREIGN KEY (facilitykey) REFERENCES public.facility(facilitykey);

ALTER TABLE public.bills
ADD CONSTRAINT bills_fromdatekey_fkey FOREIGN KEY (fromdatekey) REFERENCES public.dates(datekey);

ALTER TABLE public.bills
ADD CONSTRAINT bills_todatekey_fkey FOREIGN KEY (todatekey) REFERENCES public.dates(datekey);	
	
------------------------------------------------------------------------------------------

-- public.consumption definition

CREATE TABLE public.consumption (
	utilityproviderkey int4 NOT NULL,
	facilitykey int4 NOT NULL,
	fromdatekey int4 NOT NULL,
	todatekey int4 NOT NULL,
	numberofunits float8 NULL,
	averageunits float8 NULL,
	usageperiod float8 NULL,
	CONSTRAINT consumption_pkey PRIMARY KEY (utilityproviderkey, facilitykey, fromdatekey, todatekey)
);

-- public.consumption foreign keys

ALTER TABLE public.consumption
ADD CONSTRAINT consumption_facilitykey_fkey FOREIGN KEY (facilitykey) REFERENCES public.facility(facilitykey);

ALTER TABLE public.consumption
ADD CONSTRAINT consumption_fromdatekey_fkey FOREIGN KEY (fromdatekey) REFERENCES public.dates(datekey);

ALTER TABLE public.consumption
ADD CONSTRAINT consumption_todatekey_fkey FOREIGN KEY (todatekey) REFERENCES public.dates(datekey);
