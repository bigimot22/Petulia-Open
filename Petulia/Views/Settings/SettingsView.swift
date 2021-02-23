//
//  SettingsView.swift
//  Petulia
//
//  Created by Johandre Delgado on 10.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var theme: ThemeManager
  
  var action: ((_: Bool)->())?
  @State private var isDirty = false
  
  @AppStorage(Keys.savedPostcode) var postcode = ""
  @AppStorage(Keys.showOnlyPostWithImages) var showOnlyWithImages = true
  
  @State private var typing = false
  
  @State private var darkMode = false
  @State private var accent = Color.pink
  @State private var showColorPicker = false
  
  var body: some View {
    ZStack (alignment: .bottom) {
      VStack {
        titleBar()
          .padding([.horizontal, .top])
        
        VStack {
          Form {
            resultSessionView()
            themeSessionView()
            aboutSessionView()
          }
          if !typing {
          footerView()
            .foregroundColor(.secondary)
          }
        }
        .font(.body)
        .toggleStyle(SwitchToggleStyle(tint: accent))
        .background(Color(UIColor.systemGroupedBackground))
        Spacer()
      }
      
      if typing {
        KeyboardToolBarView()
      }
    }
    .preferredColorScheme(darkMode ? .dark : .light)
    .onAppear {
      accent = theme.accentColor
      darkMode = theme.isDark
    }
    .onDisappear {
      action?(isDirty)
    }
  }
}

// MARK: - Components
private extension SettingsView {
  func titleBar() -> some View {
    VStack {
      ZStack(alignment: .topTrailing) {
        Text("Settings")
          .font(.title)
          .frame(maxWidth: .infinity)
          .padding(.top)
          .padding(.horizontal, 100)
        
        Button(action: {
          self.hideKeyboard()
          presentationMode.wrappedValue.dismiss()
          
        }) {
          Image(systemName: "xmark.circle.fill")
            .font(.system(size: 24))
        }
        .accentColor(Color(UIColor.systemGray2))
      }
    }
  }
  
  func resultSessionView() -> some View {
    Section(header: Text("Results").font(.subheadline)) {
      TextField("Default Postcode", text: $postcode, onEditingChanged: { (changed) in
        withAnimation {
          typing = changed
        }
        isDirty = true
      })
      .keyboardType(.phonePad)
      .disableAutocorrection(true)
      
      Toggle(isOn: $showOnlyWithImages) {
        Text("Only posts with images")
      }
    }
  }
  
  func themeSessionView() -> some View {
    Section(header: Text("Theme").font(.subheadline)) {
      Toggle(isOn: $darkMode.animation()) {
        Text("Dark Mode")
      }
      .onChange(of: darkMode) { bool in
        theme.setToDarkMode(bool)
      }
      
      HStack {
        Text("Accent Color")
        Spacer()
        ZStack {
          Circle()
            .fill(Color(UIColor.secondarySystemFill))
          Circle().fill(accent).padding(3)
        }
        .frame(maxWidth: 30)
      }
      .contentShape(Rectangle())
      .onTapGesture {
        showColorPicker.toggle()
      }
      .sheet(isPresented: $showColorPicker) {
        LimitedColorPicker(limitedColors: theme.colors, chosenColor: $accent)
          .foregroundColor(.primary)
          .preferredColorScheme(darkMode ? .dark : .light)
      }
      .onChange(of: accent) { color in
        theme.setAccentColor(to: color)
      }
    }
  }
  
  func aboutSessionView() -> some View {
    Section(header: Text("About").font(.subheadline)) {
      HStack {
        Text("Version")
        Spacer()
        Text(UIApplication.appVersionNumber ?? "Unavailable")
      }
      
      HStack {
        Text("Build")
        Spacer()
        Text(UIApplication.appBuildNumber ?? "Unavailable")
      }
      
    }
  }
  
  func footerView() -> some View {
    VStack(alignment: .center) {
      Text(Keys.authorQuote)
      HStack(spacing: 0) {
        Text("By ")
        Link(destination: URL(string: Keys.authorWebsite)!) {
          Text(Keys.author)
            .underline()
        }
      }
      .padding(.bottom, 8)
    }
  }
}
