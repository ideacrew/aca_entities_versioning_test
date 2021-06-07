# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Fdsh
    module Ridp
      module H139

        # Extend DryTypes to include Ridp
        module Types
          include Dry.Types
          include Dry::Logic

          LevelOfProofingCodeKind = Types::Coercible::String.enum("LevelTwo",
                                                                  "LevelThree",
                                                                  "OptionThree").freeze

          PersonLanguagePreference = Types::Coercible::String.default('eng').enum("eng", "spa").freeze

          PayPeriodFrequencyCodeSimplekind = Types::Coercible::String.enum("Annual",
                                                                           "SemiAnnual",
                                                                           "Monthly",
                                                                           "SemiMonthly",
                                                                           "BiWeekly",
                                                                           "Weekly",
                                                                           "Daily").freeze

          PayFrequencyCodeSimpleKind = Types::Coercible::String.enum("Annual",
                                                                     "SemiAnnual",
                                                                     "Monthly",
                                                                     "SemiMonthly",
                                                                     "BiWeekly",
                                                                     "Weekly",
                                                                     "Daily",
                                                                     "Hourly",
                                                                     "13 Times/Year",
                                                                     "Commission Only",
                                                                     "10 Times/Year",
                                                                     "Guaranteed Income",
                                                                     "11 Times/Year",
                                                                     "Owner Base Pay",
                                                                     "Hourly w/o Commission",
                                                                     "Hourly + Commission",
                                                                     "Quarterly",
                                                                     "Monthly Pension",
                                                                     "Monthly - 2x Jan; no pay Dec",
                                                                     "Hourly or Commission").freeze

          UsStateCodeMap = {
            ALASKA: "AK",
            MAINE: "ME",
            "NEW JERSEY": "NJ",
            WASHINGTON: "WA",
            "Armed Forces Pacific": "AP",
            "NEW YORK": "NY",
            IOWA: "IA",
            MISSOURI: "MO",
            CONNECTICUT: "CT",
            "AMERICAN SAMOA": "AS",
            "Armed Forces Americas (except Canada)": "AA",
            WYOMING: "WY",
            "VIRGIN ISLANDS": "VI",
            GUAM: "GU",
            "PUERTO RICO": "PR",
            "FEDERATED STATES OF MICRONESIA": "FM",
            OKLAHOMA: "OK",
            OHIO: "OH",
            MINNESOTA: "MN",
            FLORIDA: "FL",
            MARYLAND: "MD",
            VIRGINIA: "VA",
            GEORGIA: "GA",
            COLORADO: "CO",
            INDIANA: "IN",
            "SOUTH DAKOTA": "SD",
            UTAH: "UT",
            MICHIGAN: "MI",
            PALAU: "PW",
            KENTUCKY: "KY",
            DELAWARE: "DE",
            CALIFORNIA: "CA",
            HAWAII: "HI",
            MASSACHUSETTS: "MA",
            "NEW MEXICO": "NM",
            "RHODE ISLAND": "RI",
            ALABAMA: "AL",
            "DISTRICT OF COLUMBIA": "DC",
            OREGON: "OR",
            TEXAS: "TX",
            LOUISIANA: "LA",
            TENNESSEE: "TN",
            NEBRASKA: "NE",
            "NORTH CAROLINA": "NC",
            ARIZONA: "AZ",
            "NEW HAMPSHIRE": "NH",
            "WEST VIRGINIA": "WV",
            ILLINOIS: "IL",
            ARKANSAS: "AR",
            MONTANA: "MT",
            VERMONT: "VT",
            MISSISSIPPI: "MS",
            "SOUTH CAROLINA": "SC",
            KANSAS: "KS",
            NEVADA: "NV",
            "NORTHERN MARIANA ISLANDS": "MP",
            "MARSHALL ISLANDS": "MH",
            "Armed Forces Africa, Canada, Europe, Middle East": "AE",
            "NORTH DAKOTA": "ND",
            IDAHO: "ID",
            PENNSYLVANIA: "PA",
            WISCONSIN: "WI"
          }.freeze

          UsStateAbbreviationKind = Types::String.enum('AL',
                                                       'AK',
                                                       'AS',
                                                       'AZ',
                                                       'AR',
                                                       'CA',
                                                       'CO',
                                                       'CT',
                                                       'DE',
                                                       'DC',
                                                       'FM',
                                                       'FL',
                                                       'GA',
                                                       'GU',
                                                       'HI',
                                                       'ID',
                                                       'IL',
                                                       'IN',
                                                       'IA',
                                                       'KS',
                                                       'KY',
                                                       'LA',
                                                       'ME',
                                                       'MH',
                                                       'MD',
                                                       'MA',
                                                       'MI',
                                                       'MN',
                                                       'MS',
                                                       'MO',
                                                       'MT',
                                                       'NE',
                                                       'NV',
                                                       'NH',
                                                       'NJ',
                                                       'NM',
                                                       'NY',
                                                       'NC',
                                                       'ND',
                                                       'MP',
                                                       'OH',
                                                       'OK',
                                                       'OR',
                                                       'PW',
                                                       'PA',
                                                       'PR',
                                                       'RI',
                                                       'SC',
                                                       'SD',
                                                       'TN',
                                                       'TX',
                                                       'UT',
                                                       'VT',
                                                       'VI',
                                                       'VA',
                                                       'WA',
                                                       'WV',
                                                       'WI',
                                                       'WY').freeze

        end
      end
    end
  end
end
