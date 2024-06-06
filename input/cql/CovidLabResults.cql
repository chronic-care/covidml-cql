library CovidLabResults version '1.0.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'
include FHIRCommon version '1.0.0' called FC
include USCoreFHIRElements version '1.0.0' called UE
include CovidConcepts called Cx

context Patient

/// Report QA analysis with count of resources, no PHI.
define ReportLabResultsQA: 
{
  "Lab Results Count": Count(UE."All Laboratory Results"),
  "Lab Results Without Preferred Code": Count("Lab Results Without Preferred Code"),

  "COVID19 Lab Tests": Count("COVID19 Lab Tests"),
  "Hemoglobin A1C": Count("Hemoglobin A1C"),
  "Blood Urea Nitrogen": Count("Blood Urea Nitrogen"),
  "Bilirubin lab test": Count("Bilirubin lab test"),
  "Troponin Lab Test": Count("Troponin Lab Test"),
  "Ferritin": Count("Ferritin"),
  "Glucose Tolerance Testing": Count("Glucose Tolerance Testing"),
  "Cerebral Spinal Fluid (CSF) Analysis": Count("Cerebral Spinal Fluid (CSF) Analysis"),

  "Arterial Blood Gas": Count("Arterial Blood Gas"),
  "Comprehensive Metabolic Panel": Count("Comprehensive Metabolic Panel"),
  "Calcium in Blood, Serum or Plasma": Count("Calcium in Blood, Serum or Plasma"),
  "Magnesium in Blood, Serum or Plasma": Count("Magnesium in Blood, Serum or Plasma"),
  "Magnesium in Urine": Count("Magnesium in Urine"),
  "Chloride, Urine": Count("Chloride, Urine"),
  "Chloride, Blood, Serum, or Plasma": Count("Chloride, Blood, Serum, or Plasma"),
  "Creatinine, Urine": Count("Creatinine, Urine"),
  "Creatinine, Blood, Serum, or Plasma": Count("Creatinine, Blood, Serum, or Plasma"),
  "Phosphate Blood, Serum, or Plasma": Count("Phosphate Blood, Serum, or Plasma")
}

// Most recent FHIR Observation for each laboratory data element.
define ReportLabResults: {
  "COVID19 Lab Tests": "COVID19 Lab Tests".mostRecentResult(),
  "Hemoglobin A1C": "Hemoglobin A1C".mostRecentResult(),
  "Blood Urea Nitrogen": "Blood Urea Nitrogen".mostRecentResult(),
  "Bilirubin lab test": "Bilirubin lab test".mostRecentResult(),
  "Troponin Lab Test": "Troponin Lab Test".mostRecentResult(),
  "Ferritin": "Ferritin".mostRecentResult(),
  "Glucose Tolerance Testing": "Glucose Tolerance Testing".mostRecentResult(),
  "Cerebral Spinal Fluid (CSF) Analysis": "Cerebral Spinal Fluid (CSF) Analysis".mostRecentResult(),

  "Arterial Blood Gas": "Arterial Blood Gas".mostRecentResult(),
  "Comprehensive Metabolic Panel": "Comprehensive Metabolic Panel".mostRecentResult(),
  "Calcium in Blood, Serum or Plasma": "Calcium in Blood, Serum or Plasma".mostRecentResult(),
  "Magnesium in Blood, Serum or Plasma": "Magnesium in Blood, Serum or Plasma".mostRecentResult(),
  "Magnesium in Urine": "Magnesium in Urine".mostRecentResult(),
  "Chloride, Urine": "Chloride, Urine".mostRecentResult(),
  "Chloride, Blood, Serum, or Plasma": "Chloride, Blood, Serum, or Plasma".mostRecentResult(),
  "Creatinine, Urine": "Creatinine, Urine".mostRecentResult(),
  "Creatinine, Blood, Serum, or Plasma": "Creatinine, Blood, Serum, or Plasma".mostRecentResult(),
  "Phosphate Blood, Serum, or Plasma": "Phosphate Blood, Serum, or Plasma".mostRecentResult()
}

define "Lab Results Without Preferred Code":
  UE."All Laboratory Results" obs
    where obs.preferredCode() is null

// Returns a System.Code with sytem and code parameters
define fluent function preferredCode(observation Observation):
  First(
    observation.code.coding c
      let preferredCode: c.preferredCoding()
      where preferredCode.code is not null
      return preferredCode
  )

define fluent function preferredCoding(c FHIR.Coding):
  case
    when c.system.value = 'http://loinc.org' then
      System.Code { system: 'http://loinc.org', code: c.code.value, display: c.display.value }
    else
      null
  end

// TODO: omit the units
define fluent function mostRecentResult(observations List<Observation>):
  FC.ResultText(observations.mostRecent())

// Lab Result FHIR Observations sorted in descending order by issue date.

define "COVID19 Lab Tests":
  ([Observation: Cx."COVID19 Lab Tests"]).resulted()

define "Hemoglobin A1C":
  ([Observation: Cx."Hemoglobin A1C"]).resulted()

define "Blood Urea Nitrogen":
  ([Observation: Cx."Blood Urea Nitrogen"]).resulted()

define "Bilirubin lab test":
  ([Observation: Cx."Bilirubin lab test"]).resulted()

define "Troponin Lab Test":
  ([Observation: Cx."Troponin Lab Test"]).resulted()

define "Ferritin":
  ([Observation: Cx."Ferritin"]).resulted()

define "Glucose Tolerance Testing":
  ([Observation: Cx."Glucose Tolerance Testing"]).resulted()

define "Cerebral Spinal Fluid (CSF) Analysis":
  ([Observation: Cx."Cerebral Spinal Fluid (CSF) Analysis"]).resulted()


define "Arterial Blood Gas":
  ([Observation: Cx."Arterial Blood Gas"]).resulted()

define "Comprehensive Metabolic Panel":
  ([Observation: Cx."Comprehensive Metabolic Panel"]).resulted()

define "Calcium in Blood, Serum or Plasma":
  ([Observation: Cx."Calcium in Blood, Serum or Plasma"]).resulted()

define "Magnesium in Blood, Serum or Plasma":
  ([Observation: Cx."Magnesium in Blood, Serum or Plasma"]).resulted()

define "Magnesium in Urine":
  ([Observation: Cx."Magnesium in Urine"]).resulted()

define "Chloride, Urine":
  ([Observation: Cx."Chloride, Urine"]).resulted()

define "Chloride, Blood, Serum, or Plasma":
  ([Observation: Cx."Chloride, Blood, Serum, or Plasma"]).resulted()

define "Creatinine, Urine":
  ([Observation: Cx."Creatinine, Urine"]).resulted()

define "Creatinine, Blood, Serum, or Plasma":
  ([Observation: Cx."Creatinine, Blood, Serum, or Plasma"]).resulted()

define "Phosphate Blood, Serum, or Plasma":
  ([Observation: Cx."Phosphate Blood, Serum, or Plasma"]).resulted()
