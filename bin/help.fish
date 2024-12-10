#!/usr/bin/env fish

# Check if at least one file is provided
if test (count $argv) -lt 1
    echo "Usage: "(status filename)" <process-compose.yml> [more-compose-files.yml...]"
    exit 1
end

# Format and display processes, with clear yq expression formatting
yq eval-all '
    # First merge all input documents
    reduce .[] as $item (
        {};
        . *+ $item
    ) |

    # Extract processes and prepare for grouping
    .processes |
    to_entries |

    # Group by namespace, using "default" if not specified
    group_by(
        .value.namespace // "default"
    ) |

    # Process each namespace group
    .[] |

    # Output namespace header
    "\(
        .[0].value.namespace // "default"
    ):\n" +

    # Format each process entry in the namespace
    (.[] |
        "  \(.key)\t" +
        "\(.value.description // \"No description\")\t" +
        "\(.value.source_file // \"\")\n"
    )
' $argv |
    column -t -s \t
