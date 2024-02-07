/* START - Get All fields based on section/card name 
=====================================================*/
DECLARE @section VARCHAR(50) = '<section_name>'
DECLARE @seriesCode VARCHAR(50) = '<series_code>'

/* Get section Id */

DECLARE @seriesId int = (	SELECT	intFormSeriesId 
							FROM	mstFormSeries 
							WHERE	vcSeriesCode = @seriesCode 
							AND		dtDeletedDate IS NULL
						)
PRINT @seriesId

DECLARE @sectionId int = (	SELECT	intSectionRowFieldMapID 
							FROM	tblSectionRowFieldMappings 
							WHERE	vcMappingType = 'section' 
							AND		intSeriesID = @seriesId
							AND		vcSectionRowLabel = @section 
							AND		dtDeletedDate IS NULL )

PRINT @sectionId

select			m.intFormFieldId, 
				f.vcFieldName, 
				f.vcFieldType		
FROM			tblSectionRowFieldMappings m
inner join		mstFormFields f
on				m.intFormFieldId = f.intFormFieldId
where			m.intSectionRowFieldMapID in 
											(	/*Number of fields belongs to rows */
												SELECT	intSectionRowFieldMapID 
												FROM	tblSectionRowFieldMappings 
												WHERE	intSectionRowMapID in 
																	(	/* Number of rows belonging */
																		SELECT	intSectionRowFieldMapID 
																		FROM	tblSectionRowFieldMappings 
																		where	intSectionMapID = @sectionId
																	)
											) 

/* ================= END - Get All fields based on section/card name =================*/


/*Get field mapping details based on stepid*/
DECLARE @StepName NVARCHAR(MAX) = 'Que'

DECLARE @formStepID INT = (select top 1 intFormStepId from mstFormSteps where vcName like '%'+@StepName+'%' and dtCreateDate is not null and intFormSeriesId = 4) 
select	* 
from	tblSectionRowFieldMappings 
where	intSeriesID = 4 
and		intStepID = @formStepID 
and		dtCreateDate is not null




/* Update fields by field id from master fields tables */
update mstFormFields set vcFieldType = 'title-name', vcOptions = '[{"label":"Mr.","value":"Mr."},{"label":"Mrs.","value":"Mrs."},{"label":"Dr.","value":"Dr."},{"label":"Er.","value":"Er."}]' where intFormFieldId in (
11,
73,
98)



/* delete record from mapping table */
delete from tblSectionRowFieldMappings where intSectionRowFieldMapID = 1215




-- Turn on identity insert for the table
SET IDENTITY_INSERT tblSectionRowFieldMappings ON;

--insert
-- Turn off identity insert for the table
SET IDENTITY_INSERT tblSectionRowFieldMappings OFF;


SELECT		m.intSectionRowFieldMapID,
			m.intReflexQuestionTypeId,
			m.intSectionRowMapID,
			m.btVisible,
			m.vcMappingType,
			m.vcSectionRowLabel,
			m.vcMoreInfo,
			m.intFormFieldId,
			f.vcFieldName,
			f.vcFieldLabel,
			m.intPositionDesktop,
			m.intPositionTablet,
			m.intPositionMobile,
			m.vcValidations,
			m.vcDependentOn
FROM		tblSectionRowFieldMappings m
left join	mstFormFields f
ON			m.intFormFieldId = f.intFormFieldId
WHERE		m.intStepID = 24 and m.intSeriesID = 4 
ORDER BY	m.intSectionRowFieldMapID


select * from tblPF_HealthConditions where vcApplicationNumber = 'K00000023'
select * from tblPF_HealthConditionsDetails where vcApplicationNumber = 'K00000023'



/* Get all the the table names from database */
USE [OnboardingMaster]
SELECT table_name = t.name
FROM sys.tables t
ORDER BY t.name;


/* Get information by application number */
declare @appNumber NVARCHAR(100) = 'K00000094'
select * from tblPF_PersonalDetails where vcApplicationNumber = @appNumber
select * from tblPF_CommunicationDetails where vcApplicationNumber = @appNumber




/* Fatca Details */
select	btFatca,
		vcInsurerOrApplicationNumber,
		vcAddressJurisdiction,
		vcTaxIdentificationNumber,
		vcValidityOfDocumentaryEvidence
from	tblPF_OtherDetails


/* Other la */
select	btHadCriminalRecord,
		btIsPoliticalAssociated,
		btIsWithPoliticalParty,
		vcInsurerNumber,
		vcToBeInsured,
		vcDeathSumAssured,
		vcPremiumPerAnnum,
		dtMonthAndYearOfInssuance,
		vcAcceptanceTerm,
		vcCurrentStatus,
		vcOffenceDetails,
		vcPoliticalAssociationDetails
from	tblPF_OtherDetails


/* lifestyle */
select	btCovid19,
		btConsumeTobacco,
		btconsumeAlcohol,
		vcConsumeNarcotics,
		bthazardousHobbiesSports,
		vcOwnAsset,
		dtAdmission,
		dtDischarge,
		btIcuRequirement,
		vcComplicationDetails,
		btIscomplicationSuffered,
		intHardLiquorPerWeek,
		intBeerBottlesPerWeek,
		intWineGlassPerWeek,
		vcNameOfDrug,
		vcHobbiesOrSportsRisk
from	tblPF_LifeStyleDetails 
where	vcApplicationNumber = 'K00000057'


/* form 60 */
select	btAppliedForPan,
		vcIdentityDocument,
		vcIdentityDocumentCode,
		vcIdentityDocumentNumber,
		vcDocumentAddressLine1,
		vcDocumentAddressLine2,
		vcDocumentCountry,
		vcDocumentState,
		vcDocumentCity,
		vcDocumentPincode,
		vcSupportOfAddressDocument,
		vcSupportOfAddressDocumentCode,
		vcSupportOfAddressIdentificationNumber,
		vcIssuingDocumentAddressLine1,
		vcIssuingDocumentAddressLine2,
		vcIssuingDocumentCountry,
		vcIssuingDocumentState,
		vcIssuingDocumentCity,
		vcIssuingDocumentPincode
from	tblPF_Form60Questions 
where	vcApplicationNumber = 'K00000057'


/* Check reflexive fields by type id */
select	intReflexQuestionTypeId,* 
from	tblSectionRowFieldMappings  
where	intSeriesID is null 
and		intStepID is null 
and		intReflexQuestionTypeId = 24



/* Remove summery declaration by application number */
UPDATE	tblPF_Applications 
SET		btVerifiedFormSubmission = 0, 
		dtVerifiedFormSubmissionOn = null,
		intApplicationStatus = 0,
		intCompleteStatus = 0,
		intFormStepNo = 5
WHERE	vcApplicationNumber = 'K00000101'


/* Get fields by row id */
select		m.intSectionRowFieldMapID,
			f.vcFieldName,
			f.vcFieldLabel,
			m.intPositionDesktop
FROM		tblSectionRowFieldMappings m
left join	mstFormFields f
ON			m.intFormFieldId = f.intFormFieldId
where		m.intSectionRowMapID = 139
order by	m.intPositionDesktop asc


/* Update validation by id */
update tblSectionRowFieldMappings set vcValidations = 'REQ, DREQ' where intSectionRowFieldMapID = 2383

/* Get validation by ids */
select intSectionRowFieldMapID,vcValidations from tblSectionRowFieldMappings where intSectionRowFieldMapID in(
128,
129,
2383
)

/* Get dependent record by questionnaire id */
SELECT	vcDependentOn,* 
FROM	tblSectionRowFieldMappings 
WHERE	intReflexQuestionTypeID = 2
AND		vcDependentOn is not null

/* delete scr details by app number */
select* from tblPF_ScrDetails where vcApplicationNumber = 'K00000101'


