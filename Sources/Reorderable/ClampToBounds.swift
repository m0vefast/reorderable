import SwiftUI

private struct ClampToBoundsEnvironmentKey: EnvironmentKey {
  static let defaultValue: Bool = false
}

extension EnvironmentValues {
  package var clampToBounds: Bool {
    get { self[ClampToBoundsEnvironmentKey.self] }
    set { self[ClampToBoundsEnvironmentKey.self] = newValue }
  }
}

private struct ClampToBoundsViewModifier: ViewModifier {
  let clamp: Bool

  func body(content: Content) -> some View {
    content
      .environment(\.clampToBounds, clamp)
  }
}

extension ReorderableVStack {
  /// Prevents dragged elements from leaving the bounds of this ``ReorderableVStack``.
  ///
  /// When enabled, the dragged element's offset is clamped so it cannot
  /// visually exceed the top or bottom edge of the list.
  ///
  /// - Parameters:
  ///    - clamp: A Boolean value that determines whether dragged elements are constrained to the list bounds.
  ///
  /// - Returns: A view that constrains dragged elements to the list bounds.
  public func clampDragToBounds(_ clamp: Bool = true) -> some View {
    modifier(ClampToBoundsViewModifier(clamp: clamp))
  }
}

extension ReorderableHStack {
  /// Prevents dragged elements from leaving the bounds of this ``ReorderableHStack``.
  ///
  /// When enabled, the dragged element's offset is clamped so it cannot
  /// visually exceed the leading or trailing edge of the list.
  ///
  /// - Parameters:
  ///    - clamp: A Boolean value that determines whether dragged elements are constrained to the list bounds.
  ///
  /// - Returns: A view that constrains dragged elements to the list bounds.
  public func clampDragToBounds(_ clamp: Bool = true) -> some View {
    modifier(ClampToBoundsViewModifier(clamp: clamp))
  }
}
