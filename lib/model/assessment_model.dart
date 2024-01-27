class AssessmentModel {
  AssessmentModel({
    required this.id,
    required this.name,
    required this.assessmentDate,
    required this.description,
    required this.type,
    required this.roleAssessor,
    required this.roleAssessorName,
    required this.roleParticipant,
    required this.roleParticipantName,
    required this.departementId,
    required this.departementName,
    required this.siteLocationId,
    required this.siteLocationName,
    required this.image,
    this.participants,
    this.assessors,
    required this.createdAt,
    required this.updatedAt,
    this.downloadedAt,
    required this.hasResponses,
  });
  late final String id;
  late final String name;
  late final String assessmentDate;
  late final String description;
  late final String type;
  late final int roleAssessor;
  late final String roleAssessorName;
  late final int roleParticipant;
  late final String roleParticipantName;
  late final String departementId;
  late final String departementName;
  late final String siteLocationId;
  late final String siteLocationName;
  late final String image;
  late final List<Participants>? participants;
  late final Null assessors;
  late final String createdAt;
  late final String updatedAt;
  late final Null downloadedAt;
  late final bool hasResponses;

  AssessmentModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    assessmentDate = json['assessment_date'];
    description = json['description'];
    type = json['type'];
    roleAssessor = json['role_assessor'];
    roleAssessorName = json['role_assessor_name'];
    roleParticipant = json['role_participant'];
    roleParticipantName = json['role_participant_name'];
    departementId = json['departement_id'];
    departementName = json['departement_name'];
    siteLocationId = json['site_location_id'];
    siteLocationName = json['site_location_name'];
    image = json['image'];
    participants = List.from(json['participants']??[]).map((e)=>Participants.fromJson(e)).toList();
    assessors = json['assessors'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    downloadedAt = json['downloaded_at'];
    hasResponses = json['has_responses'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['assessment_date'] = assessmentDate;
    _data['description'] = description;
    _data['type'] = type;
    _data['role_assessor'] = roleAssessor;
    _data['role_assessor_name'] = roleAssessorName;
    _data['role_participant'] = roleParticipant;
    _data['role_participant_name'] = roleParticipantName;
    _data['departement_id'] = departementId;
    _data['departement_name'] = departementName;
    _data['site_location_id'] = siteLocationId;
    _data['site_location_name'] = siteLocationName;
    _data['image'] = image;
    _data['participants'] = participants?.map((e)=>e.toJson()).toList();
    _data['assessors'] = assessors;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['downloaded_at'] = downloadedAt;
    _data['has_responses'] = hasResponses;
    return _data;
  }
}

class Participants {
  Participants({
    required this.nik,
    required this.name,
    required this.departement,
    required this.departementId,
    required this.role,
    required this.roleId,
    required this.siteLocation,
    required this.siteLocationId,
    required this.totalAssessment,
    required this.lastAssessment,
    required this.imageProfile,
    required this.createdAt,
  });
  late final String nik;
  late final String name;
  late final String departement;
  late final String departementId;
  late final String role;
  late final int roleId;
  late final String siteLocation;
  late final String siteLocationId;
  late final int totalAssessment;
  late final String lastAssessment;
  late final String imageProfile;
  late final String createdAt;

  Participants.fromJson(Map<String, dynamic> json){
    nik = json['nik'];
    name = json['name'];
    departement = json['departement'];
    departementId = json['departement_id'];
    role = json['role'];
    roleId = json['role_id'];
    siteLocation = json['site_location'];
    siteLocationId = json['site_location_id'];
    totalAssessment = json['total_assessment'];
    lastAssessment = json['last_assessment'];
    imageProfile = json['image_profile'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nik'] = nik;
    _data['name'] = name;
    _data['departement'] = departement;
    _data['departement_id'] = departementId;
    _data['role'] = role;
    _data['role_id'] = roleId;
    _data['site_location'] = siteLocation;
    _data['site_location_id'] = siteLocationId;
    _data['total_assessment'] = totalAssessment;
    _data['last_assessment'] = lastAssessment;
    _data['image_profile'] = imageProfile;
    _data['created_at'] = createdAt;
    return _data;
  }
}