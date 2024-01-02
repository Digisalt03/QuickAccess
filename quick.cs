//Entity with enum
entity.Property(e => e.intApplicationStatus)
.HasConversion(new EnumToNumberConverter<ApplicationStatus, int>());
