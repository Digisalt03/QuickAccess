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
