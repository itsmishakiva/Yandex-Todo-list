class DBMapConverter {
  static Map<String, dynamic> convertTask(Map<String, dynamic> taskMap) {
    taskMap.forEach((key, value) {
      if (value == false) taskMap[key] = 0;
      if (value == true) taskMap[key] = 1;
    });
    return taskMap;
  }
}
