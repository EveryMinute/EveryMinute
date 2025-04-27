//
//  AddRoutineView.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 04.04.25.
//

import SwiftUI
import MapKit

internal enum RoutineType {
    case routine
    case calendarEntry
    case lesson
}

private enum Periods : String, RawRepresentable, CaseIterable, Equatable {
    case hourly
    case daily
    case weekly
    case monthly
    case yearly
}

internal struct AddRoutineView: View {
    
    /// The Type of Routine to add
    internal let type : RoutineType
    
    @Environment(\.managedObjectContext) private var context
    
    /// All courses to connect a lesson to
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.name)]
    ) private var courses : FetchedResults<Course>
    
    /* Generel */
    
    /// Name of the entry
    @State private var name : String = ""
    
    /* Date & Time */
    
    /// Date of the entry - if it's a periodical entry, the start date
    @State private var date : Date = Date.now
    
    /// End date of the periodical entry
    @State private var endDate : Date = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    
    /// whether the entry is periodical or not
    @State private var periodical : Bool = false
    
    /// The period of this interval
    @State private var period : Periods = .daily
    
    /// The default duration of this entry
    @State private var duration : Int32 = 60
    
    /// interval in whith the event reoccurs
    @State private var interval : Int32 = 0
    
    /// the DatePicker components to display
    private var dateComponents : DatePickerComponents {
        // Inline computation of date picker components
        var components = DatePickerComponents()
        components.insert(.date)
        if type == .calendarEntry {
            components.insert(.hourAndMinute)
        }
        return components
    }
    
    /* Location */
    
    /// the country of the entries location
    @State private var country : String = ""
    
    /// the zip code of the entries location, if there is any
    @State private var zip : String = ""
    
    /// the address of the entries location
    @State private var address : String = ""
    
    /// The coordinates of the locaiton
    @State private var coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    /* Advanced */
    
    /// Notes to this entry specifiying it more
    @State private var notes : String = ""
    
    /* Course */
    
    /// The course the lesson is in
    @State private var selectedCourse : Course?
    
    /* Connection */
    
    /// all possible profiles to select from to connect this entry to
    @State private var profiles : [Profile] = []
    
    /// The profile selected to connect the entry to
    @State private var profile : Profile?
    
    /* Errors */
    
    /// setting this to true will display an alert stating an error while loading the profiles
    @State private var errLoadingProfilesShown : Bool = false
    
    /// setting this to true will display an alert stating an error while saving the entry
    @State private var errSavingEntryShown : Bool = false
    
    /* View related */
    
    private var navigationTitleText: String {
        return switch type {
        case .routine:
            "New Routine"
        case .calendarEntry:
            "New Calendar Entry"
        case .lesson:
            "New Lesson"
        }
    }
    
    var body: some View {
        AddItemSheetWrapper {
            // TODO: update done function
            let newItem : Routine
            switch type {
            case .routine:
                newItem = Routine(context: context)
            case .calendarEntry:
                let calendarEntry = CalendarEntry(context: context)
                calendarEntry.duration = duration
                calendarEntry.location = [
                    "country": country,
                    "zipCode": zip,
                    "address": address,
                    "longitude": coordinates.longitude,
                    "latitude": coordinates.latitude
                ]
                calendarEntry.notes = notes
                calendarEntry.profile = profile
                newItem = calendarEntry
            case .lesson:
                newItem = Lesson(context: context)
            }
            newItem.name = name
            newItem.date = date
            newItem.endDate = endDate
            newItem.interval = interval
            newItem.notes = notes
            do {
                try context.save()
            } catch {
                errSavingEntryShown.toggle()
            }
        } content: {
            List {
                Section {
                    TextField("Name", text: $name)
                    TextField("Notes", text: $notes)
                    Picker("Profile", selection: $profile) {
                        // Needed to provide default option
                        // Tag needed to provide tags as profile? when selection only contains non-optionals
                        Text("No profile").tag(nil as Profile?)
                        ForEach(profiles) {
                            profile in
                            Text(profile.name!).tag(profile as Profile?)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Information")
                } footer: {
                    Text("Specify the Routine")
                }
                Section {
                    if type == .calendarEntry {
                        Toggle("Periodical", isOn: $periodical.animation())
                    }
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: dateComponents
                    )
                    if periodical {
                        Picker("Period", selection: $period) {
                            ForEach(Periods.allCases, id: \.rawValue) {
                                p in
                                Text(p.rawValue).tag(p)
                            }
                        }
                        .onChange(of: period) { calculateEndDate() }
                        DatePicker(
                            "End Date",
                            selection: $endDate,
                            displayedComponents: dateComponents
                            
                        )
                    }
                } header: {
                    Text("Date")
                } footer: {
                    Text("Specify first and following dates")
                }
                if type == .calendarEntry {
                    Section {
                        TextField("Adress", text: $address)
                            .textContentType(.fullStreetAddress)
                            .onChange(of: address) { updateCoordinates() }
                        TextField("ZIP", text: $zip)
                            .textContentType(.postalCode)
                            .onChange(of: zip) { updateCoordinates() }
                        TextField("Country", text: $country)
                            .textContentType(.countryName)
                            .onChange(of: country) { updateCoordinates() }
                        NavigationLink {
                            Map {
                                Marker(address, coordinate: coordinates)
                            }
                            .mapControls {
#if !os(iOS)
                                MapZoomStepper()
#endif
                            }
                            .mapControlVisibility(.visible)
                        } label: {
                            Label("View on Map", systemImage: "map")
                                .foregroundStyle(.primary)
                        }
                    } header: {
                        Text("Adress")
                    } footer: {
                        Text("The location of your event")
                    }
                }
                if type == .lesson {
                    Section {
                        Picker("Course", selection: $selectedCourse) {
                            Text("No course").tag(nil as Course?)
                            ForEach(courses) {
                                course in
                                Text(course.name!).tag(course as Course?)
                            }
                        }
                    } header: {
                        Text("Course")
                    } footer: {
                        Text("Link the lesson to a specific course")
                    }
                }
            }
            .onAppear {
                do {
                    profiles = try Storage.loadProfiles(context)
                } catch {
                    errLoadingProfilesShown.toggle()
                }
            }
            .alert(
                "Error loading Profiles",
                isPresented: $errLoadingProfilesShown
            ) {
                
            } message: {
                Text("There's been an error while trying to load your custom profiles. Please try again")
            }
            .alert("Error saving Entry", isPresented: $errSavingEntryShown) {
                
            } message: {
                Text("There's been an error while trying to save your new entry. Please try again")
            }
#if os(macOS)
            .frame(width: 400, height: 200)
#endif
            .navigationTitle(navigationTitleText)
#if os(iOS)
            .navigationBarTitleDisplayMode(.automatic)
#endif
        }
    }
    
    /// Calculate the end date depending on the period and interval
    private func calculateEndDate() -> Void {
        let component : Calendar.Component
        var value : Int = 1
        switch period {
        case .hourly:
            component = .hour
        case .daily:
            component = .day
        case .weekly:
            component = .day
            value = 7
        case .monthly:
            component = .month
        case .yearly:
            component = .year
        }
        endDate = Calendar.current.date(
            byAdding: component,
            value: value,
            to: date
        ) ?? endDate
    }
    
    /// Sets the interval as an int
    private func setInterval() -> Void {
        interval = switch period {
        case .hourly:
            1       // 1
        case .daily:
            24      // 24
        case .weekly:
            168     // 7 * 24
        case .monthly:
            672     // 7 * 24 * 4
        case .yearly:
            8064    // 7 * 24 * 4 * 12
        }
    }
    
    /// Tries to find the coordinates based on the address, zip code and country
    private func updateCoordinates() -> Void {
        // Reference: https://stackoverflow.com/questions/42279252/convert-address-to-coordinates-swift
        // Answer: https://stackoverflow.com/a/42279676
        let coder = CLGeocoder()
        coder.geocodeAddressString("\(address), \(zip), \(country)") {
            placemarks, error in
            guard
                let placemark = placemarks,
                let location = placemark.first?.location
            else {
                EveryMinuteApp.logger.log(
                    level: .error,
                    "Error finding location for provided address parts:\n[Error: \(String(describing: error))]\nProvided parts: \(address),\(zip), \(country)"
                )
                return
            }
            coordinates = location.coordinate
        }
    }
}

#Preview("Calendar Entry") {
    AddRoutineView(type: .calendarEntry)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

#Preview("Routine") {
    AddRoutineView(type: .routine)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

#Preview("Lesson") {
    AddRoutineView(type: .lesson)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
