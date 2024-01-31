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






