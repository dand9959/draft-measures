//for 2020 reporting year. QDM to QI-4
//Intensive Care Unit Venous Thromboembolism Prophylaxis
//Author: TJC
library EXM190_FHIR4 version '8.2.000'

using FHIR version '4.0.0'

include FHIRHelpers version '4.0.0' called FHIRHelpers
include MATGlobalCommonFunctions_FHIR4 version '4.0.000' called Global
include SupplementalDataElements_FHIR4 version '1.0.0' called SDE
include VTEICU_FHIR4 version '3.1.000' called VTEICU
include TJC_Overall_FHIR4 version '4.0.000' called TJC

codesystem "SNOMEDCT": 'http://snomed.info/sct/731000124108'
codesystem "LOINC": 'http://loinc.org'
// NOTE: R4 code system URLs changed to be based on terminology.hl7.org...
codesystem "RequestIntent": 'http://terminology.hl7.org/CodeSystem/request-intent'
//NOTE: Created for condition.clinicalStatus which is codeableConcept
codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'

//NOTE: Created for ActPriority for Encounter.category which is codeableConcept
codesystem "ActPriority": 'http://terminology.hl7.org/ValueSet/v3-ActPriority'

valueset "Atrial Fibrillation/Flutter": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.202'
valueset "Comfort Measures": 'https://cts.nlm.nih.gov/fhir/ValueSet/1.3.6.1.4.1.33895.1.3.0.45'
valueset "Direct Thrombin Inhibitor": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.205'
valueset "Emergency Department Visit": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "General or Neuraxial Anesthesia": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.1743'
valueset "General Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.255'
valueset "Glycoprotein IIb/IIIa Inhibitors": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.41'
valueset "Graduated compression stockings (GCS)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.256'
valueset "Gynecological Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.257'
valueset "Hemorrhagic Stroke": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.212'
valueset "Hip Fracture Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.258'
valueset "Hip Replacement Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.259'
valueset "Injectable Factor Xa Inhibitor for VTE Prophylaxis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.211'
valueset "INR": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.213'
valueset "Intermittent pneumatic compression devices (IPC)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.214'
valueset "Intracranial Neurosurgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.260'
valueset "Intravenous route": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.222'
valueset "Ischemic Stroke": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.247'
valueset "Knee Replacement Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.261'
valueset "Low Dose Unfractionated Heparin for VTE Prophylaxis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.39'
valueset "Low Molecular Weight Heparin for VTE Prophylaxis": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.219'
valueset "Low Risk": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.400'
valueset "Medical Reason": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.473'
valueset "Mental Health Diagnoses": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.105.12.1004'
valueset "Obstetrics": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.263'
valueset "Obstetrics VTE": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.264'
valueset "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.134'
valueset "Patient Refusal": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.93'
valueset "Subcutaneous route": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.223'
valueset "Unfractionated Heparin": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.218'
valueset "Urological Surgery": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.272'
valueset "Venous foot pumps (VFP)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.230'
valueset "Venous Thromboembolism": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.279'
valueset "Warfarin": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.232'
valueset "Intensive Care Unit": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.23'

code "Risk for venous thromboembolism": '72136-5' from "LOINC" display 'Risk for venous thromboembolism'

//NOTE: Created for condition.clinicalStatus which is codeableConcept
code "active": 'active' from "ConditionClinicalStatusCodes"
code "recurrence": 'recurrence' from "ConditionClinicalStatusCodes"
code "relapse": 'relapse' from "ConditionClinicalStatusCodes"
code "inactive": 'inactive' from "ConditionClinicalStatusCodes"
code "remission": 'remission' from "ConditionClinicalStatusCodes"
code "resolved": 'resolved' from "ConditionClinicalStatusCodes"

//NOTE: Created for ActPriority for Encounter.category which is codeableConcept
code "elective": 'elective' from "ActPriority"


context Patient

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
	SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
	SDE."SDE Sex"

define "Admission Without VTE or Obstetrical Conditions":
		Global."Inpatient Encounter" InpatientEncounter
		where not (Global.EncounterDiagnosis(InpatientEncounter).code in "Obstetrics"
								or Global.EncounterDiagnosis(InpatientEncounter).code in "Venous Thromboembolism"
								or Global.EncounterDiagnosis(InpatientEncounter).code in "Obstetrics VTE"
							)

// Note: added FHIRHelpers.ToDate() in R4
define "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions":
  ( Global."Inpatient Encounter" InpatientEncounter
  		with ["Patient"] BirthDate
  			such that Global."CalendarAgeInYearsAt"(FHIRHelpers.ToDate(BirthDate.birthDate), start of InpatientEncounter.period) >= 18
  )
  intersect "Admission Without VTE or Obstetrical Conditions"


define "Initial Population":
	"Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions"


define "Encounter With ICU Location":
  "Encounter With Age Range and Without VTE Diagnosis or Obstetrical Conditions" QualifyingEncounter
  	where exists (QualifyingEncounter.location Location
				where Global.GetLocation(Location.location).type in "Intensive Care Unit"
  			and Location.period during QualifyingEncounter.period
  	)

define "Denominator":
  "Encounter With ICU Location"


define "Encounter With ICU Location And Encounter Less Than 2 Days":
  "Encounter With ICU Location"QualifyingEncounterICU
  	where Global."LengthInDays"(QualifyingEncounterICU.period)< 2

define "SCIP VTE Selected Surgery":
	(	["Procedure": "General Surgery"]
		union ["Procedure": "Gynecological Surgery"]
		union ["Procedure": "Hip Fracture Surgery"]
		union ["Procedure": "Hip Replacement Surgery"]
		union ["Procedure": "Intracranial Neurosurgery"]
		union ["Procedure": "Knee Replacement Surgery"]
		union ["Procedure": "Urological Surgery"] ) P
		where P.status = 'completed'


define function GetExtension(Resource FHIR.DomainResource, Url String):
  First(
		Resource.extension E
	  	where E.url = Url
	)

define function GetExtension(Element FHIR.Element, Url String):
  First(
		Element.extension E
	  	where E.url = Url
	)

/* NOTE: 2 options to express Principal Procedure to retrive "encounter Procedure as an url" and proedure "rank as extension" in R4
          VTE-1 uses Option 1 - generic extension funtion
          VTE-2 uses Option 2 - Specific extension functions
  TODO:  Mapping Table needs revision on using "Encounter.procedure.code", "Encounter.procedure.sequence"
*/

define function GetEncounterProcedure(encounter Encounter):
	 GetExtension(encounter, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-encounter-procedure')

define function GetRank(encounterProcedure Extension):
  FHIRHelpers.ToInteger(GetExtension(encounterProcedure, 'rank').value as FHIR.positiveInt)

define function GetProcedureId(encounterProcedure Extension):
    Global.GetId(FHIRHelpers.ToString((GetExtension(encounterProcedure, 'procedure').value as FHIR.Reference).reference))

define "Encounter With First ICU Stay With Principal Procedure of SCIP VTE Selected Surgery":
from
  "Encounter With ICU Location" QualifyingEncounterICU,
  "SCIP VTE Selected Surgery" SelectedProcedure
  let EncounterProcedure: GetEncounterProcedure(QualifyingEncounterICU)
where GetRank(EncounterProcedure) = 1
  and GetProcedureId(EncounterProcedure) = SelectedProcedure.id
  and FHIRHelpers.ToInterval(SelectedProcedure.performed as Period) ends during TJC."CalendarDayOfOrDayAfter"(VTEICU."StartOfFirstICU"(QualifyingEncounterICU))

define "Intervention Comfort Measures":
	(["ServiceRequest": "Comfort Measures"] P
		where P.intent = 'order')
	union
    	(["Procedure": "Comfort Measures"] IntervetionPerformed
      	where IntervetionPerformed.status in {'completed', 'in-progress'})

//TODO - need "as Period" replace "as dateTime in Coalesce(start of ComfortMeasure.performed as Period). Noticed that it occurs within Coalesce() only
define "Encounter With Intervention Comfort Measures From Day Of Start of Hospitalization To Day After First ICU Stay":
    "Encounter With ICU Location" QualifyingEncounterICU
      with "Intervention Comfort Measures" ComfortMeasure
    	// Note: "start of performed as Period" doe not work - Noticed that it occurs within Coalesce() only
    	such that FHIRHelpers.ToDateTime(Coalesce(ComfortMeasure.performed as dateTime,ComfortMeasure.authoredOn)) during VTEICU."FromDayOfStartOfHospitalizationToDayAfterFirstICU"(QualifyingEncounterICU)


define "Encounter With Intervention Comfort Measures on Day of or Day After Procedure":
  from
    "Encounter With ICU Location" QualifyingEncounterICU,
    ["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
    "Intervention Comfort Measures" ComfortMeasure
    where  AnesthesiaProcedure.status = 'completed'
      	and AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
        //Note - "start of ComfortMeasure.performed as Period" does not work
        and FHIRHelpers.ToDateTime(Coalesce(ComfortMeasure.authoredOn, ComfortMeasure.performed as dateTime)) during TJC."CalendarDayOfOrDayAfter"(
    			end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
    	return QualifyingEncounterICU

define "Denominator Exclusions":
  "Encounter With ICU Location And Encounter Less Than 2 Days"
  union "Encounter With First ICU Stay With Principal Procedure of SCIP VTE Selected Surgery"
	union "Encounter With Intervention Comfort Measures From Day Of Start of Hospitalization To Day After First ICU Stay"
	union "Encounter With Intervention Comfort Measures on Day of or Day After Procedure"


define "VTE Prophylaxis by Medication Administered or Device Applied":
  ( ["MedicationAdministration": medication in "Low Dose Unfractionated Heparin for VTE Prophylaxis"] VTEMedication
  		where VTEMedication.status ='completed' //'in-progress' is okay to meet
  					and VTEMedication.dosage.route in "Subcutaneous route"
  )
  	union (["MedicationAdministration": medication in "Low Molecular Weight Heparin for VTE Prophylaxis"] LMWH where LMWH.status = 'completed')
  	union (["MedicationAdministration": medication in "Injectable Factor Xa Inhibitor for VTE Prophylaxis"] FactorXa where FactorXa.status = 'completed')
  	union (["MedicationAdministration": medication in "Warfarin"] Warfarin where Warfarin.status = 'completed')
  	union ((
  			["DeviceUseStatement": code in "Intermittent pneumatic compression devices (IPC)"]
  			union ["DeviceUseStatement": code in "Venous foot pumps (VFP)"]
  			union ["DeviceUseStatement": code in "Graduated compression stockings (GCS)"]
      ) DeviceApplied
  			where DeviceApplied.status = 'active'
    )

//TODO - need "as Period" replace "as dateTime in Coalesce(start of VTEProphylaxis.timing as Period, start of VTEProphylaxis.effective as Period)
define "Encounter With VTE Prophylaxis Received on Day of or Day After First ICU Stay or Procedure":
	( from
			"Encounter With ICU Location" QualifyingEncounterICU,
			"VTE Prophylaxis by Medication Administered or Device Applied" VTEProphylaxis
			where FHIRHelpers.ToDateTime(Coalesce(VTEProphylaxis.effective, VTEProphylaxis.timing as dateTime)) during TJC."CalendarDayOfOrDayAfter"(VTEICU."StartOfFirstICU"(QualifyingEncounterICU))
			return QualifyingEncounterICU
	)
	union ( from
				"Encounter With ICU Location" QualifyingEncounterICU,
				["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
				"VTE Prophylaxis by Medication Administered or Device Applied" VTEProphylaxis
				where AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
					and FHIRHelpers.ToDateTime(Coalesce(VTEProphylaxis.effective, VTEProphylaxis.timing as dateTime)) during TJC."CalendarDayOfOrDayAfter"(
  				end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
            return QualifyingEncounterICU
        )

define "Encounter With Medication Oral Factor Xa Inhibitor Administered on Day of or Day After First ICU Stay or Procedure":
( from
    "Encounter With ICU Location" QualifyingEncounterICU,
     ["MedicationAdministration": medication in "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
      where FactorXaMedication.effective as Period starts during TJC."CalendarDayOfOrDayAfter"(VTEICU."StartOfFirstICU"(QualifyingEncounterICU))
      return QualifyingEncounterICU
   )
  union ( from
    			 "Encounter With ICU Location" QualifyingEncounterICU,
    			["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
    			["MedicationAdministration": medication in "Oral Factor Xa Inhibitor for VTE Prophylaxis or VTE Treatment"] FactorXaMedication
    			where AnesthesiaProcedure.status = 'completed'
    				and AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
    					and FactorXaMedication.effective as Period starts during TJC."CalendarDayOfOrDayAfter"(
      				end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
    			return QualifyingEncounterICU
        	)

/*NOTE: Feedback at Digitial Quality Summit 2019 indicates verificationStatus may be difficult for implementers to retrieve
          and AtrialFibrillation.verificationStatus = 'confirmed'
*/
define "Encounter With Prior or Present Diagnosis of Atrial Fibrillation or VTE":
	( "Encounter With ICU Location" QualifyingEncounterICU
		with ["Condition": code in "Atrial Fibrillation/Flutter"] AtrialFibrillation
		such that FHIRHelpers.ToConcept(AtrialFibrillation.clinicalStatus) in {"active", "recurrence", "relapse"}
			and FHIRHelpers.ToDateTime(AtrialFibrillation.onset as dateTime) on or before end of QualifyingEncounterICU.period
	)
union ( "Encounter With ICU Location" QualifyingEncounterICU
				where Global.EncounterDiagnosis(QualifyingEncounterICU).code in "Atrial Fibrillation/Flutter"
			)
union ( "Encounter With ICU Location" QualifyingEncounterICU
				with ["Condition": code in "Venous Thromboembolism"] VTEDiagnosis
				such that  FHIRHelpers.ToConcept(VTEDiagnosis.clinicalStatus) in { "inactive", "remission", "resolved" }
			//and VTEDiagnosis.verificationStatus = 'confirmed'
					and FHIRHelpers.ToDateTime(VTEDiagnosis.onset as dateTime) before start of QualifyingEncounterICU.period
  		)


define "Encounter With Prior or Present Procedure of Hip or Knee Replacement Surgery":
	"Encounter With ICU Location" QualifyingEncounterICU
	with ( ["Procedure": "Hip Replacement Surgery"]
  			union ["Procedure": "Knee Replacement Surgery"] ) HipKneeProcedure
	such that HipKneeProcedure.status = 'completed'
			and FHIRHelpers.ToInterval(HipKneeProcedure.performed as Period) starts on or before end of QualifyingEncounterICU.period

// TODO: start of AnticoagulantMedication.effective as Period doe not work
define "Is In Low Risk for VTE or On Anticoagulant":
	( ["Observation": "Risk for venous thromboembolism"] VTERiskAssessment
		where VTERiskAssessment.value in "Low Risk"
        and VTERiskAssessment.status in {'final','amended', 'corrected'}
  	)
  union ( ["Observation": "INR"] INRLabTest
          where INRLabTest.value as Quantity > 3.0
              and INRLabTest.status in {'final','amended', 'corrected'}
              return "Observation" { id: INRLabTest.id, effective: INRLabTest.issued }
        )
  union ((( ["MedicationAdministration": "Unfractionated Heparin"] UnfractionatedHeparin
          where UnfractionatedHeparin.dosage.route in "Intravenous route"
          )
        union ["MedicationAdministration": "Direct Thrombin Inhibitor"]
        union ["MedicationAdministration": "Glycoprotein IIb/IIIa Inhibitors"] ) AnticoagulantMedication
        return "Observation" { id: AnticoagulantMedication.id, effective: AnticoagulantMedication.effective as dateTime}
        )

define "Low Risk for VTE or Anticoagulant Administered From Day of Start of Hospitalization To Day After First ICU Stay":
  "Encounter With ICU Location" QualifyingEncounterICU
  with "Is In Low Risk for VTE or On Anticoagulant" VTERiskAssessment
  such that FHIRHelpers.ToDateTime(VTERiskAssessment.effective as dateTime) during VTEICU."FromDayOfStartOfHospitalizationToDayAfterFirstICU"(QualifyingEncounterICU)

define "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Procedure":
  from
  	"Encounter With ICU Location" QualifyingEncounterICU,
  	["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
  	"Is In Low Risk for VTE or On Anticoagulant" LowRiskForVTE
  where AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
  	and FHIRHelpers.ToDateTime(LowRiskForVTE.effective as dateTime) during TJC."CalendarDayOfOrDayAfter"(end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
  return QualifyingEncounterICU


define "Encounter With Low Risk for VTE or Anticoagulant Administered":
  "Low Risk for VTE or Anticoagulant Administered From Day of Start of Hospitalization To Day After First ICU Stay"
  union "Low Risk for VTE or Anticoagulant Administered on Day of or Day After Procedure"

  define "No VTE Prophylaxis Medication Administered or Ordered":
  	((	["MedicationAdministration": medication in "Low Dose Unfractionated Heparin for VTE Prophylaxis"]
  	union
  	["MedicationAdministration": medication in "Low Molecular Weight Heparin for VTE Prophylaxis"]
  	union
  	["MedicationAdministration": medication in "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
  	union
  	["MedicationAdministration": medication in "Warfarin"]
  	) MedicationAdm
  		where MedicationAdm.status = 'not-done'
  	)
  	union
  	((	["MedicationRequest": medication in "Low Dose Unfractionated Heparin for VTE Prophylaxis"]
  	union
  	["MedicationRequest": medication in "Low Molecular Weight Heparin for VTE Prophylaxis"]
  	union
  	["MedicationRequest": medication in "Injectable Factor Xa Inhibitor for VTE Prophylaxis"]
  	union
  	["MedicationRequest": medication in "Warfarin"]
  	) MedicationOrder
  	where	FHIRHelpers.ToBoolean(MedicationOrder.doNotPerform) is true
  	)


define "No VTE Prophylaxis Medication Due to Medical Reason From Day Of Start of Hospitalization To Day After First ICU Stay":
	from
		"Encounter With ICU Location" QualifyingEncounterICU,
		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
		where Coalesce(NoVTEMedication.statusReason,NoVTEMedication.reasonCode) in "Medical Reason"
			and FHIRHelpers.ToDateTime(Coalesce(NoVTEMedication.authoredOn, NoVTEMedication.effective as dateTime)) during VTEICU."FromDayOfStartOfHospitalizationToDayAfterFirstICU"(QualifyingEncounterICU)
    return QualifyingEncounterICU

//Note - "start of NoVTEMedication.effective as Period" does not work
define "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Procedure":
	from
  		"Encounter With ICU Location" QualifyingEncounterICU,
  		["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
  		"No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
  where  Coalesce(NoVTEMedication.statusReason,NoVTEMedication.reasonCode) in "Medical Reason"
  		and AnesthesiaProcedure.status = 'completed'
  		and AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
  		and FHIRHelpers.ToDateTime(Coalesce(NoVTEMedication.authoredOn, NoVTEMedication.effective as dateTime)) during TJC."CalendarDayOfOrDayAfter"(
        end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
  return QualifyingEncounterICU


  /*: TODO: Mapping Table review - neither DeviceRequest nor DeviceUseStatement reasonCode could be used for not done reasonCode
     In R4 - Use Extensions to get Not done reason for DeviceRequest and DeviceUseStatement
       DeviceUseStatement not-done-reason uses extension 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-devicerequest-doNotPerformReason'
       DeviceUseRequest not-done-reason uses extension 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-deviceusestatement-notDoneReason'
       GForge ticket # 20601
    NOTE: 2 options to retrive those information in the logic and the Option_2 is more effecient after comparing 2 options -
        Option_1 is to express the extensions by using generic extension functions as below -
             FHIRHelpers.ToBoolean(GetExtension(DeviceApplied, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-deviceusestatement-notDone').value)
             FHIRHelpers.ToCode(GetExtension(DeviceApplied, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-deviceusestatement-notDoneReason').value)
                    in "Medical Reason"
        Option_2 is to define Specific extension functions to retrive Information (used by VTE-1 and VTE-2)
  */

  define function GetNotDone(deviceUseStatement DeviceUseStatement):
      FHIRHelpers.ToBoolean(GetExtension(deviceUseStatement, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-deviceusestatement-notDone').value)

  define function GetNotDoneReason(deviceUseStatement DeviceUseStatement):
      FHIRHelpers.ToCode(GetExtension(deviceUseStatement, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-deviceusestatement-notDoneReason').value)

  define function GetDoNotPerfom(deviceRequest DeviceRequest):
      FHIRHelpers.ToBoolean(GetExtension(deviceRequest, 'http://hl7.org/fhir/StructureDefinition/request-doNotPerform').value)

  define function GetNotPerformReason(deviceRequest DeviceRequest):
      FHIRHelpers.ToCode(GetExtension(deviceRequest, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-devicerequest-doNotPerformReason').value)

  define "No VTE Prophylaxis Device Applied or Ordered":
      ((["DeviceUseStatement": code in "Venous foot pumps (VFP)"]
        union ["DeviceUseStatement": code in "Intermittent pneumatic compression devices (IPC)"]
        union ["DeviceUseStatement": code in "Graduated compression stockings (GCS)"]
        ) DeviceApplied
          where GetNotDone(DeviceApplied) is true
      )
      union ((
          ["DeviceRequest": code in "Venous foot pumps (VFP)"]
          union ["DeviceRequest": code in "Intermittent pneumatic compression devices (IPC)"]
          union ["DeviceRequest": code in "Graduated compression stockings (GCS)"]
          ) DeviceOrder
            where GetDoNotPerfom(DeviceOrder) is true
          )


define "No VTE Prophylaxis Device Due to Medical Reason From Day of Start of Hospitalization To Day After First ICU Stay":
  	"Encounter With ICU Location" QualifyingEncounterICU
    with "No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
    such that (GetNotDoneReason(NoVTEDevice) in "Medical Reason"
                or GetNotPerformReason(NoVTEDevice) in "Medical Reason")
        and FHIRHelpers.ToDateTime(Coalesce(NoVTEDevice.authoredOn, NoVTEDevice.recordedOn)) during VTEICU."FromDayOfStartOfHospitalizationToDayAfterFirstICU"(QualifyingEncounterICU)


define "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Procedure":
	from
		"Encounter With ICU Location" QualifyingEncounterICU,
		["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
		where  (GetNotDoneReason(NoVTEDevice) in "Medical Reason"
              or GetNotPerformReason(NoVTEDevice) in "Medical Reason")
        and AnesthesiaProcedure.status = 'completed'
        and AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
        and FHIRHelpers.ToDateTime(Coalesce(NoVTEDevice.authoredOn, NoVTEDevice.recordedOn)) during TJC."CalendarDayOfOrDayAfter"(
			         end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
		return QualifyingEncounterICU


define "Encounter With No VTE Prophylaxis Due to Medical Reason":
  ( "No VTE Prophylaxis Medication Due to Medical Reason From Day Of Start of Hospitalization To Day After First ICU Stay"
    intersect "No VTE Prophylaxis Device Due to Medical Reason From Day of Start of Hospitalization To Day After First ICU Stay"
  )
  union ( "No VTE Prophylaxis Medication Due to Medical Reason on Day of or Day After Procedure"
      intersect "No VTE Prophylaxis Device Due to Medical Reason on Day of or Day After Procedure"
  )


define "No VTE Prophylaxis Medication or Device Due to Patient Refusal":
  ( "No VTE Prophylaxis Medication Administered or Ordered" NoVTEMedication
      where  Coalesce(NoVTEMedication.statusReason,NoVTEMedication.reasonCode) in "Patient Refusal"
    )
  union ("No VTE Prophylaxis Device Applied or Ordered" NoVTEDevice
         where GetNotDoneReason(NoVTEDevice) in "Patient Refusal"
             or GetNotPerformReason(NoVTEDevice) in "Patient Refusal"
        )

define "No VTE Prophylaxis Due to Patient Refusal From Day of Start of Hospitalization To Day After First ICU Stay":
	"Encounter With ICU Location" QualifyingEncounterICU
		with "No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
    such that FHIRHelpers.ToDateTime(Coalesce(PatientRefusal.effective, PatientRefusal.authoredOn, PatientRefusal.recordedOn))
      during VTEICU.FromDayOfStartOfHospitalizationToDayAfterFirstICU(QualifyingEncounterICU)


define "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Procedure":
	from
		"Encounter With ICU Location" QualifyingEncounterICU,
		["Procedure": "General or Neuraxial Anesthesia"] AnesthesiaProcedure,
		"No VTE Prophylaxis Medication or Device Due to Patient Refusal" PatientRefusal
		where AnesthesiaProcedure.performed as Period ends 1 day after day of VTEICU."StartOfFirstICU"(QualifyingEncounterICU)
			and FHIRHelpers.ToDateTime(Coalesce(PatientRefusal.effective as dateTime, PatientRefusal.authoredOn, PatientRefusal.recordedOn))
        during TJC."CalendarDayOfOrDayAfter"(
  			end of FHIRHelpers.ToInterval(AnesthesiaProcedure.performed as Period))
		return QualifyingEncounterICU


define "Encounter With No VTE Prophylaxis Due to Patient Refusal":
"No VTE Prophylaxis Due to Patient Refusal From Day of Start of Hospitalization To Day After First ICU Stay"
	union "No VTE Prophylaxis Due to Patient Refusal on Day of or Day After Procedure"


define "Numerator":
"Encounter With VTE Prophylaxis Received on Day of or Day After First ICU Stay or Procedure"
	union ( "Encounter With Medication Oral Factor Xa Inhibitor Administered on Day of or Day After First ICU Stay or Procedure"
			intersect ( "Encounter With Prior or Present Diagnosis of Atrial Fibrillation or VTE"
					union "Encounter With Prior or Present Procedure of Hip or Knee Replacement Surgery"
			)
	)
	union "Encounter With Low Risk for VTE or Anticoagulant Administered"
	union "Encounter With No VTE Prophylaxis Due to Medical Reason"
	union "Encounter With No VTE Prophylaxis Due to Patient Refusal"


define "Encounter With First ICU Location Stay Less Than 1 day":
  "Encounter With ICU Location" QualifyingEncounterICU
	 where Global."LengthInDays"(VTEICU."FirstICULocationPeriod"(QualifyingEncounterICU))< 1

define "Denominator Exceptions":
  "Encounter With First ICU Location Stay Less Than 1 day"