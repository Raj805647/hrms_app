import 'package:base_module/base_module.dart';

class EmployeeDashboardResponse extends BaseModel {
  EmployeeDashboardResponse({
    super.status,
    super.message,
    super.statusCode,
    this.data,
  });

  EmployeeDashboardResponse.fromJson(dynamic json) {
    data = json['data'] != null
        ? EmployeeDashboardData.fromJson(json['data'])
        : null;
  }
  EmployeeDashboardData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class EmployeeDashboardData {
  EmployeeDashboardData({
    this.user,
    this.employeeTodayAttendance,
    this.overview,
    this.officeTime,
    this.company,
    this.employeeWeeklyReport,
    this.dateInAd,
    this.attendanceNote,
    this.shiftDates,
    this.features,
    this.teamMembers,
    this.addNfc,
    this.recentHoliday,
    this.recentAward,
    this.recentTraining,
    this.recentEvent,
  });

  EmployeeDashboardData.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    employeeTodayAttendance = json['employee_today_attendance'] != null
        ? EmployeeTodayAttendance.fromJson(json['employee_today_attendance'])
        : null;
    overview =
        json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    officeTime = json['office_time'] != null
        ? OfficeTime.fromJson(json['office_time'])
        : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    employeeWeeklyReport = json['employee_weekly_report'] != null
        ? json['employee_weekly_report'].cast<String>()
        : [];
    dateInAd = json['date_in_ad'];
    attendanceNote = json['attendance_note'];
    shiftDates =
        json['shift_dates'] != null ? json['shift_dates'].cast<String>() : [];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(Features.fromJson(v));
      });
    }
    if (json['teamMembers'] != null) {
      teamMembers = [];
      json['teamMembers'].forEach((v) {
        teamMembers?.add(TeamMembers.fromJson(v));
      });
    }
    addNfc = json['add_nfc'];
    recentHoliday = json['recent_holiday'] != null
        ? RecentHoliday.fromJson(json['recent_holiday'])
        : null;
    recentAward = json['recent_award'];
    recentTraining = json['recent_training'] != null
        ? RecentTraining.fromJson(json['recent_training'])
        : null;
    recentEvent = json['recent_event'];
  }
  User? user;
  EmployeeTodayAttendance? employeeTodayAttendance;
  Overview? overview;
  OfficeTime? officeTime;
  Company? company;
  List<String>? employeeWeeklyReport;
  bool? dateInAd;
  bool? attendanceNote;
  List<String>? shiftDates;
  List<Features>? features;
  List<TeamMembers>? teamMembers;
  bool? addNfc;
  RecentHoliday? recentHoliday;
  String? recentAward;
  RecentTraining? recentTraining;
  String? recentEvent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (employeeTodayAttendance != null) {
      map['employee_today_attendance'] = employeeTodayAttendance?.toJson();
    }
    if (overview != null) {
      map['overview'] = overview?.toJson();
    }
    if (officeTime != null) {
      map['office_time'] = officeTime?.toJson();
    }
    if (company != null) {
      map['company'] = company?.toJson();
    }
    map['employee_weekly_report'] = employeeWeeklyReport;
    map['date_in_ad'] = dateInAd;
    map['attendance_note'] = attendanceNote;
    map['shift_dates'] = shiftDates;
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    if (teamMembers != null) {
      map['teamMembers'] = teamMembers?.map((v) => v.toJson()).toList();
    }
    map['add_nfc'] = addNfc;
    if (recentHoliday != null) {
      map['recent_holiday'] = recentHoliday?.toJson();
    }
    map['recent_award'] = recentAward;
    if (recentTraining != null) {
      map['recent_training'] = recentTraining?.toJson();
    }
    map['recent_event'] = recentEvent;
    return map;
  }
}

class RecentTraining {
  RecentTraining({
    this.id,
    this.trainingType,
    this.employee,
    this.branch,
    this.department,
    this.description,
    this.cost,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.certificate,
    this.trainer,
  });

  RecentTraining.fromJson(dynamic json) {
    id = json['id'];
    trainingType = json['training_type'];
    if (json['employee'] != null) {
      employee = [];
      json['employee'].forEach((v) {
        employee?.add(Employee.fromJson(v));
      });
    }
    branch = json['branch'];
    if (json['department'] != null) {
      department = [];
      json['department'].forEach((v) {
        department?.add(Department.fromJson(v));
      });
    }
    description = json['description'];
    cost = json['cost'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    certificate = json['certificate'];
    if (json['trainer'] != null) {
      trainer = [];
      json['trainer'].forEach((v) {
        trainer?.add(Trainer.fromJson(v));
      });
    }
  }
  int? id;
  String? trainingType;
  List<Employee>? employee;
  String? branch;
  List<Department>? department;
  String? description;
  int? cost;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? certificate;
  List<Trainer>? trainer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['training_type'] = trainingType;
    if (employee != null) {
      map['employee'] = employee?.map((v) => v.toJson()).toList();
    }
    map['branch'] = branch;
    if (department != null) {
      map['department'] = department?.map((v) => v.toJson()).toList();
    }
    map['description'] = description;
    map['cost'] = cost;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['certificate'] = certificate;
    if (trainer != null) {
      map['trainer'] = trainer?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Trainer {
  Trainer({
    this.id,
    this.trainerType,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.expertise,
    this.isTrainer,
    this.userId,
  });

  Trainer.fromJson(dynamic json) {
    id = json['id'];
    trainerType = json['trainer_type'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    expertise = json['expertise'];
    isTrainer = json['is_trainer'];
    userId = json['user_id'];
  }
  int? id;
  String? trainerType;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? expertise;
  bool? isTrainer;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['trainer_type'] = trainerType;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    map['expertise'] = expertise;
    map['is_trainer'] = isTrainer;
    map['user_id'] = userId;
    return map;
  }
}

class Department {
  Department({
    this.id,
    this.name,
  });

  Department.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Employee {
  Employee({
    this.id,
    this.name,
  });

  Employee.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class RecentHoliday {
  RecentHoliday({
    this.id,
    this.event,
    this.eventDate,
    this.nepaliDate,
    this.description,
    this.isPublicHoliday,
  });

  RecentHoliday.fromJson(dynamic json) {
    id = json['id'];
    event = json['event'];
    eventDate = json['event_date'];
    nepaliDate = json['nepali_date'];
    description = json['description'];
    isPublicHoliday = json['is_public_holiday'];
  }
  int? id;
  String? event;
  String? eventDate;
  String? nepaliDate;
  String? description;
  bool? isPublicHoliday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event'] = event;
    map['event_date'] = eventDate;
    map['nepali_date'] = nepaliDate;
    map['description'] = description;
    map['is_public_holiday'] = isPublicHoliday;
    return map;
  }
}

class TeamMembers {
  TeamMembers({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.dob,
    this.gender,
    this.branch,
    this.department,
    this.post,
    this.avatar,
    this.onlineStatus,
  });

  TeamMembers.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
    branch = json['branch'];
    department = json['department'];
    post = json['post'];
    avatar = json['avatar'];
    onlineStatus = json['online_status'];
  }
  int? id;
  String? name;
  String? email;
  String? username;
  int? phone;
  String? dob;
  String? gender;
  String? branch;
  String? department;
  String? post;
  String? avatar;
  int? onlineStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['phone'] = phone;
    map['dob'] = dob;
    map['gender'] = gender;
    map['branch'] = branch;
    map['department'] = department;
    map['post'] = post;
    map['avatar'] = avatar;
    map['online_status'] = onlineStatus;
    return map;
  }
}

class Features {
  Features({
    this.name,
    this.key,
    this.status,
  });

  Features.fromJson(dynamic json) {
    name = json['name'];
    key = json['key'];
    status = json['status'];
  }
  String? name;
  String? key;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['key'] = key;
    map['status'] = status;
    return map;
  }
}

class Company {
  Company({
    this.id,
    this.name,
    this.weekend,
  });

  Company.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    weekend = json['weekend'] != null ? json['weekend'].cast<String>() : [];
  }
  int? id;
  String? name;
  List<String>? weekend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['weekend'] = weekend;
    return map;
  }
}

class OfficeTime {
  OfficeTime({
    this.id,
    this.startTime,
    this.endTime,
  });

  OfficeTime.fromJson(dynamic json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
  int? id;
  String? startTime;
  String? endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    return map;
  }
}

class Overview {
  Overview({
    this.presentDays,
    this.totalPaidLeaves,
    this.totalHolidays,
    this.totalPendingLeaves,
    this.totalLeaveTaken,
    this.totalAssignedProjects,
    this.totalPendingTasks,
    this.totalAwards,
    this.activeEvent,
    this.activeTraining,
  });

  Overview.fromJson(dynamic json) {
    presentDays = json['present_days'];
    totalPaidLeaves = json['total_paid_leaves'];
    totalHolidays = json['total_holidays'];
    totalPendingLeaves = json['total_pending_leaves'];
    totalLeaveTaken = json['total_leave_taken'];
    totalAssignedProjects = json['total_assigned_projects'];
    totalPendingTasks = json['total_pending_tasks'];
    totalAwards = json['total_awards'];
    activeEvent = json['active_event'];
    activeTraining = json['active_training'];
  }
  int? presentDays;
  int? totalPaidLeaves;
  int? totalHolidays;
  int? totalPendingLeaves;
  int? totalLeaveTaken;
  int? totalAssignedProjects;
  int? totalPendingTasks;
  int? totalAwards;
  int? activeEvent;
  int? activeTraining;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present_days'] = presentDays;
    map['total_paid_leaves'] = totalPaidLeaves;
    map['total_holidays'] = totalHolidays;
    map['total_pending_leaves'] = totalPendingLeaves;
    map['total_leave_taken'] = totalLeaveTaken;
    map['total_assigned_projects'] = totalAssignedProjects;
    map['total_pending_tasks'] = totalPendingTasks;
    map['total_awards'] = totalAwards;
    map['active_event'] = activeEvent;
    map['active_training'] = activeTraining;
    return map;
  }
}

class EmployeeTodayAttendance {
  EmployeeTodayAttendance({
    this.checkInAt,
    this.checkOutAt,
    this.productiveTimeInMin,
  });

  EmployeeTodayAttendance.fromJson(dynamic json) {
    checkInAt = json['check_in_at'];
    checkOutAt = json['check_out_at'];
    productiveTimeInMin = json['productive_time_in_min'];
  }
  String? checkInAt;
  String? checkOutAt;
  int? productiveTimeInMin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['check_in_at'] = checkInAt;
    map['check_out_at'] = checkOutAt;
    map['productive_time_in_min'] = productiveTimeInMin;
    return map;
  }
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.branch,
    this.department,
    this.workspaceType,
    this.avatar,
    this.onlineStatus,
    this.dob,
    this.gender,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    branch = json['branch'];
    department = json['department'];
    workspaceType = json['workspace_type'];
    avatar = json['avatar'];
    onlineStatus = json['online_status'];
    dob = json['dob'];
    gender = json['gender'];
  }
  int? id;
  String? name;
  String? email;
  String? username;
  String? branch;
  String? department;
  int? workspaceType;
  String? avatar;
  bool? onlineStatus;
  String? dob;
  String? gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['branch'] = branch;
    map['department'] = department;
    map['workspace_type'] = workspaceType;
    map['avatar'] = avatar;
    map['online_status'] = onlineStatus;
    map['dob'] = dob;
    map['gender'] = gender;
    return map;
  }
}
