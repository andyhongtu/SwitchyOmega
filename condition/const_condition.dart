/*!
 * Copyright (C) 2012, The SwitchyOmega Authors. Please see the AUTHORS file
 * for details.
 *
 * This file is part of SwitchyOmega.
 *
 * SwitchyOmega is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * SwitchyOmega is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with SwitchyOmega.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A [ConstCondition] always return the same value, [:true:] or [:false:].
 */
abstract class ConstCondition extends Condition {
  /**
   * Get the constant value.
   */
  abstract bool get value();
  
  /**
   * Get the constant JavaScript expression.
   */
  abstract String get expression();  
  
  /**
   * Returns [value] at all times.
   */
  bool match(String url, String host, String scheme, Date datetime) => value;
  
  /**
   * Writes [expression] to [w].
   */
  void writeTo(CodeWriter w) { w.inline(expression); }
}

/**
 * A condition that always matches.
 */
class AlwaysCondition extends ConstCondition {
  final String conditionType = 'AlwaysCondition';

  final value = true;
  final expression = 'true';
  
  static AlwaysCondition _instance = null;

  factory AlwaysCondition() {
    if (_instance != null)
      return _instance;
    else
      return _instance = new AlwaysCondition._private();
  }
  
  AlwaysCondition._private();
  
  factory AlwaysCondition.fromPlain(Map<String, Object> p, [Object config])
    => new AlwaysCondition();
}

/**
 * A condition that never matches.
 */
class NeverCondition extends ConstCondition {
  final String conditionType = 'NeverCondition';

  final value = false;
  final expression = 'false';
  
  static NeverCondition _instance = null;

  factory NeverCondition() {
    if (_instance != null)
      return _instance;
    else
      return _instance = new NeverCondition._private();
  }
  
  NeverCondition._private();
  
  factory NeverCondition.fromPlain(Map<String, Object> p, [Object config])
    => new NeverCondition();
}