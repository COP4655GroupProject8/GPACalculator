class Class {
    let name: String
    let creditHours: Int
    let grade: String
    
    init(name: String, creditHours: Int, grade: String) {
        self.name = name
        self.creditHours = creditHours
        self.grade = grade
    }
}

class Student {
    let studentID: String
    var currentGPA: Double?
    var classes: [String: [String: Class]] // Dictionary to store classes by semester and year
    
    init(studentID: String) {
        self.studentID = studentID
        self.classes = [:]
    }
    
    func addClass(semester: String, year: Int, className: String, creditHours: Int, grade: String) {
        let semesterKey = "\(semester)-\(year)"
        if self.classes[semesterKey] == nil {
            self.classes[semesterKey] = [:]
        }
        self.classes[semesterKey]?[className] = Class(name: className, creditHours: creditHours, grade: grade)
    }
    
    func calculateSemesterGPA(semester: String, year: Int) -> Double? {
        let semesterKey = "\(semester)-\(year)"
        guard let semesterClasses = self.classes[semesterKey] else {
            return nil // Semester not found
        }
        var totalQualityPoints = 0.0
        var totalCreditHours = 0
        for (_, classObj) in semesterClasses {
            totalQualityPoints += gradeToQualityPoints(grade: classObj.grade) * Double(classObj.creditHours)
            totalCreditHours += classObj.creditHours
        }
        if totalCreditHours == 0 {
            return 0
        }
        return totalQualityPoints / Double(totalCreditHours)
    }
    
    func calculateCurrentGPA() -> Double? {
        guard !self.classes.isEmpty else {
            return nil // No classes found
        }
        var totalQualityPoints = 0.0
        var totalCreditHours = 0
        for (_, semesterClasses) in self.classes {
            for (_, classObj) in semesterClasses {
                totalQualityPoints += gradeToQualityPoints(grade: classObj.grade) * Double(classObj.creditHours)
                totalCreditHours += classObj.creditHours
            }
        }
        if totalCreditHours == 0 {
            return 0
        }
        return totalQualityPoints / Double(totalCreditHours)
    }
    
    func gradeToQualityPoints(grade: String) -> Double {
        // Define your grading scale here, e.g., ["A": 4.0, "B": 3.0, "C": 2.0, ...]
        let gradingScale = ["A": 4.0, "B": 3.0, "C": 2.0, "D": 1.0, "F": 0.0]
        return gradingScale[grade] ?? 0.0
    }
    
    func getClasses(for semester: String, year: Int) -> [Class]? {
        let semesterKey = "\(semester)-\(year)"
        return self.classes[semesterKey]?.values.map { $0 }
    }

    func addClass(for semester: String, year: Int, className: String, creditHours: Int, grade: String) {
        let semesterKey = "\(semester)-\(year)"
        if self.classes[semesterKey] == nil {
            self.classes[semesterKey] = [:]
        }
        self.classes[semesterKey]?[className] = Class(name: className, creditHours: creditHours, grade: grade)
    }

    func removeClass(for semester: String, year: Int, className: String) {
        let semesterKey = "\(semester)-\(year)"
        self.classes[semesterKey]?[className] = nil
    }
}
