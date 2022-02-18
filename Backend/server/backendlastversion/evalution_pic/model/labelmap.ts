/**
 * @license
 * Copyright 2019 Google LLC. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * =============================================================================
 */

 export interface ObjectDetectionClass {
    
    id: number;
    displayName: string;
  }
  
  export const CLASSES: {[key: string]: ObjectDetectionClass} = {
    1: {
      id: 1,
      displayName: 'signboard',
    },
    2: {
      
      id: 2,
      displayName: 'electric pole',
    },
    3: {
      
      id: 3,
      displayName: 'building',
    },
    4: {
      
      id: 4,
      displayName: 'pipe',
    },
    5: {
      
      id: 5,
      displayName: 'bridge railing',
    },
    6: {
      
      id: 6,
      displayName: 'electric wire',
    },
    7: {
      
      id: 7,
      displayName: 'roof',
    },
    8: {
     
      id: 8,
      displayName: 'tree',
    },
    9: {
      
      id: 9,
      displayName: 'grass',
    },
    10: {
      
      id: 10,
      displayName: 'car',
    },
    11: {
      
      id: 11,
      displayName: 'road',
    },
    12: {
      
        id: 12,
        displayName: 'pork',
      },
    13: {
      
      id: 13,
      displayName: 'mama',
    },
    14: {
      
      id: 14,
      displayName: 'fork',
    },
    15: {
      
      id: 15,
      displayName: 'spoon',
    },
    16: {
     
      id: 16,
      displayName: 'noodle',
    },
    17: {
      
      id: 17,
      displayName: 'Kale',
    },
    18: {
     
      id: 18,
      displayName: 'pancake',
    },
    19: {
      
      id: 19,
      displayName: 'mixed vegetables',
    },
    20: {
      
      id: 20,
      displayName: 'Rice Crackers',
    },
    21: {
      
      id: 21,
      displayName: 'papaya salad',
    },
    22: {
     
      id: 22,
      displayName: 'three-flavored fish',
    },
    23: {
      
      id: 23,
      displayName: 'glass',
    },
    25: {
      
      id: 25,
      displayName: 'small basket',
    },
    26: {
      
        id: 26,
        displayName: 'Stir Fried Mushrooms',
      },
    27: {
     
      id: 27,
      displayName: 'food plate',
    },
    28: {
      
      id: 28,
      displayName: 'seafood',
    },
    29: {
      
        id: 29,
        displayName: 'mushroom',
      },
    30: {
      
        id: 30,
        displayName: 'lettuce',
      },
    31: {
      
      id: 31,
      displayName: 'tissue box',
    },
    32: {
      
      id: 32,
      displayName: 'meatball',
    },
    33: {
      
      id: 33,
      displayName: 'chopsticks',
    },
    34: {
      
      id: 34,
      displayName: 'cashew nut',
    },
    35: {
      
      id: 35,
      displayName: 'egg',
    },
    36: {
      
      id: 36,
      displayName: 'Baked Shrimp with Glass Noodles',
    },
    37: {
     
      id: 37,
      displayName: 'bean',
    },
    38: {
      
      id: 38,
      displayName: 'jar',
    },
    39: {
      
      id: 39,
      displayName: 'food',
    },
    40: {
      
      id: 40,
      displayName: 'Human',
    },
    41: {
      
      id: 41,
      displayName: 'garlic',
    },
    42: {
      
      id: 42,
      displayName: 'rice',
    },
    43: {
      
      id: 43,
      displayName: 'fried rice',
    },
    44: {
      
      id: 44,
      displayName: 'fried fish',
    },
    45: {
      
      id: 45,
      displayName: 'sink',
    },
    46: {
      
        id: 46,
        displayName: 'Curry Rice',
      },
    47: {
      
      id: 47,
      displayName: 'soup',
    },
    48: {
      
      id: 48,
      displayName: 'side dishes',
    },
    49: {
      
      id: 49,
      displayName: 'buddha',
    },
    50: {
     
      id: 50,
      displayName: 'lamp',
    },
    51: {
      
      id: 51,
      displayName: 'flower vase',
    },
    52: {
      
      id: 52,
      displayName: 'fan',
    },
    53: {
      
      id: 53,
      displayName: 'speaker',
    },
    54: {
      
      id: 54,
      displayName: 'statue',
    },
    55: {
      
      id: 55,
      displayName: 'picture',
    },
    56: {
      
      id: 56,
      displayName: 'pagoda',
    },
    57: {
      
      id: 57,
      displayName: 'vinyl',
    },
    58: {
     
      id: 58,
      displayName: 'monk',
    },
    59: {
      
      id: 59,
      displayName: 'buddha shelf',
    },
    60: {
      
      id: 60,
      displayName: 'temple roof',
    },
    61: {
      
      id: 61,
      displayName: 'wall',
    },
    62: {
      
      id: 62,
      displayName: 'glass door',
    },
    63: {
      
      id: 63,
      displayName: 'temple gate',
    },
    64: {
      
      id: 64,
      displayName: 'window',
    },
    65: {
      
      id: 65,
      displayName: 'motorcycle',
    },
    66: {
      
      id: 66,
      displayName: 'temple',
    },
    67: {
      
      id: 67,
      displayName: 'stairs',
    },
    68: {
      
      id: 68,
      displayName: 'tuk tuk',
    },
    69: {
      
      id: 69,
      displayName: 'sunshade',
    },
    70: {
      
      id: 70,
      displayName: 'pole',
    },
    71: {
      
        id: 71,
        displayName: 'light bulb',
      },
    72: {
      
        id: 72,
        displayName: 'table',
      },
      73: {
      
        id: 73,
        displayName: 'door',
      }
};