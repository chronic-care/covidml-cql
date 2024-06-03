library CovidOtherObservations version '1.0.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'
include FHIRCommon version '1.0.0' called FC
include CovidConcepts called Cx

context Patient

/// Report QA analysis with count of resources, no PHI.
define ReportOtherObservationsQA: 
{
  "Social History": Count("Social History Observations"),

  "Brain Fog": Count("Brain Fog"),
  "Impaired Sense of Smell": Count("Impaired Sense of Smell"),
  "Impaired Sense of Taste": Count("Impaired Sense of Taste"),
  "Post Exertional Malaise": Count("Post Exertional Malaise"),
  "Respiratory Distress": Count("Respiratory Distress")
}

/// Report a list of codes for all other observations.
define ReportOtherObservations: 
{
  "Social History": "Social History Observations".observationCodes(),

  "Brain Fog": "Brain Fog".observationCodes(),
  "Impaired Sense of Smell": "Impaired Sense of Smell".observationCodes(),
  "Impaired Sense of Taste": "Impaired Sense of Taste".observationCodes(),
  "Post Exertional Malaise": "Post Exertional Malaise".observationCodes(),
  "Respiratory Distress": "Respiratory Distress".observationCodes()
}

define "Social History Observations":
  ["Observation"] O
    where O.isSocialHistory()

define fluent function observationCodes(observations List<Observation>):
  (observations observation
    return observation.firstCode().code)
  
// Returns a System.Code with sytem and code parameters for first Observation coding
define fluent function firstCode(observation Observation):
  First(
    observation.code.coding c
      return System.Code { system: c.system.value, code: c.code.value, display: c.display.value }
  )

define "Brain Fog":
  ([Observation: Cx."Brain Fog"]).resulted()

define "Impaired Sense of Smell":
  ([Observation: Cx."Impaired Sense of Smell"]).resulted()

define "Impaired Sense of Taste":
  ([Observation: Cx."Impaired Sense of Taste"]).resulted()

define "Post Exertional Malaise":
  ([Observation: Cx."Post Exertional Malaise"]).resulted()

define "Respiratory Distress":
  ([Observation: Cx."Respiratory Distress"]).resulted()
