"use client"

import { useState } from "react"
import { Link } from "react-router-dom"
import { ArrowRight, CheckCircle2 } from "lucide-react"
import { Button } from "../components/ui/button"
import { Input } from "../components/ui/input"
import { Label } from "../components/ui/label"
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "../components/ui/card"

export default function SignUp() {
  const [step, setStep] = useState(1)
  const [formData, setFormData] = useState({
    orgName: "",
    domain: "",
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    confirmPassword: "",
  })
  const [errors, setErrors] = useState<Record<string, string>>({})

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target
    setFormData((prev) => ({ ...prev, [name]: value }))

    // Clear error when user types
    if (errors[name]) {
      setErrors((prev) => {
        const newErrors = { ...prev }
        delete newErrors[name]
        return newErrors
      })
    }
  }

  const validateStep1 = () => {
    const newErrors: Record<string, string> = {}

    if (!formData.orgName.trim()) {
      newErrors.orgName = "Organization name is required"
    }

    if (!formData.domain.trim()) {
      newErrors.domain = "Domain is required"
    } else if (!/^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$/.test(formData.domain)) {
      newErrors.domain = "Please enter a valid domain"
    }

    setErrors(newErrors)
    return Object.keys(newErrors).length === 0
  }

  const validateStep2 = () => {
    const newErrors: Record<string, string> = {}

    if (!formData.firstName.trim()) {
      newErrors.firstName = "First name is required"
    }

    if (!formData.lastName.trim()) {
      newErrors.lastName = "Last name is required"
    }

    if (!formData.email.trim()) {
      newErrors.email = "Email is required"
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      newErrors.email = "Please enter a valid email"
    }

    if (!formData.password) {
      newErrors.password = "Password is required"
    } else if (formData.password.length < 8) {
      newErrors.password = "Password must be at least 8 characters"
    }

    if (!formData.confirmPassword) {
      newErrors.confirmPassword = "Please confirm your password"
    } else if (formData.password !== formData.confirmPassword) {
      newErrors.confirmPassword = "Passwords do not match"
    }

    setErrors(newErrors)
    return Object.keys(newErrors).length === 0
  }

  const handleNextStep = () => {
    if (validateStep1()) {
      setStep(2)
    }
  }

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (validateStep2()) {
      // Submit form data to your backend
      console.log("Form submitted:", formData)
      // Redirect to login or dashboard
    }
  }

  const getPasswordStrength = () => {
    const { password } = formData
    if (!password) return 0

    let strength = 0
    if (password.length >= 8) strength += 1
    if (/[A-Z]/.test(password)) strength += 1
    if (/[0-9]/.test(password)) strength += 1
    if (/[^A-Za-z0-9]/.test(password)) strength += 1

    return strength
  }

  const renderPasswordStrength = () => {
    const strength = getPasswordStrength()
    const strengthText = ["Weak", "Fair", "Good", "Strong"]

    return (
      <div className="mt-1">
        <div className="flex gap-1 h-1 mb-1">
          {[1, 2, 3, 4].map((level) => (
            <div
              key={level}
              className={`h-full flex-1 rounded-full ${
                level <= strength
                  ? level === 1
                    ? "bg-red-500"
                    : level === 2
                      ? "bg-orange-500"
                      : level === 3
                        ? "bg-yellow-500"
                        : "bg-green-500"
                  : "bg-gray-200"
              }`}
            />
          ))}
        </div>
        {formData.password && (
          <p className="text-xs text-gray-500">Password strength: {strengthText[strength - 1] || "Weak"}</p>
        )}
      </div>
    )
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-50 p-4">
      <Card className="w-full max-w-md">
        <CardHeader>
          <CardTitle className="text-2xl font-bold">Create your account</CardTitle>
          <CardDescription>
            {step === 1 ? "Let's set up your organization first" : "Now, let's create your admin account"}
          </CardDescription>
        </CardHeader>

        <CardContent>
          <div className="mb-6">
            <div className="flex items-center">
              <div
                className={`flex h-8 w-8 items-center justify-center rounded-full ${
                  step >= 1 ? "bg-primary text-primary-foreground" : "bg-gray-200"
                }`}
              >
                {step > 1 ? <CheckCircle2 className="h-5 w-5" /> : 1}
              </div>
              <div className="mx-2 h-1 flex-1 bg-gray-200">
                <div className={`h-full ${step > 1 ? "bg-primary" : "bg-gray-200"}`} />
              </div>
              <div
                className={`flex h-8 w-8 items-center justify-center rounded-full ${
                  step === 2 ? "bg-primary text-primary-foreground" : "bg-gray-200"
                }`}
              >
                2
              </div>
            </div>
            <div className="mt-2 flex justify-between text-sm">
              <span>Organization</span>
              <span>Admin User</span>
            </div>
          </div>

          <form onSubmit={handleSubmit}>
            {step === 1 ? (
              <div className="space-y-4">
                <div className="space-y-2">
                  <Label htmlFor="orgName">Organization Name</Label>
                  <Input
                    id="orgName"
                    name="orgName"
                    value={formData.orgName}
                    onChange={handleChange}
                    placeholder="Acme News"
                    className={errors.orgName ? "border-red-500" : ""}
                  />
                  {errors.orgName && <p className="text-sm text-red-500">{errors.orgName}</p>}
                </div>

                <div className="space-y-2">
                  <Label htmlFor="domain">Domain</Label>
                  <Input
                    id="domain"
                    name="domain"
                    value={formData.domain}
                    onChange={handleChange}
                    placeholder="acmenews.com"
                    className={errors.domain ? "border-red-500" : ""}
                  />
                  {errors.domain && <p className="text-sm text-red-500">{errors.domain}</p>}
                </div>
              </div>
            ) : (
              <div className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="firstName">First Name</Label>
                    <Input
                      id="firstName"
                      name="firstName"
                      value={formData.firstName}
                      onChange={handleChange}
                      placeholder="John"
                      className={errors.firstName ? "border-red-500" : ""}
                    />
                    {errors.firstName && <p className="text-sm text-red-500">{errors.firstName}</p>}
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="lastName">Last Name</Label>
                    <Input
                      id="lastName"
                      name="lastName"
                      value={formData.lastName}
                      onChange={handleChange}
                      placeholder="Doe"
                      className={errors.lastName ? "border-red-500" : ""}
                    />
                    {errors.lastName && <p className="text-sm text-red-500">{errors.lastName}</p>}
                  </div>
                </div>

                <div className="space-y-2">
                  <Label htmlFor="email">Email</Label>
                  <Input
                    id="email"
                    name="email"
                    type="email"
                    value={formData.email}
                    onChange={handleChange}
                    placeholder="john@acmenews.com"
                    className={errors.email ? "border-red-500" : ""}
                  />
                  {errors.email && <p className="text-sm text-red-500">{errors.email}</p>}
                </div>

                <div className="space-y-2">
                  <Label htmlFor="password">Password</Label>
                  <Input
                    id="password"
                    name="password"
                    type="password"
                    value={formData.password}
                    onChange={handleChange}
                    className={errors.password ? "border-red-500" : ""}
                  />
                  {renderPasswordStrength()}
                  {errors.password && <p className="text-sm text-red-500">{errors.password}</p>}
                </div>

                <div className="space-y-2">
                  <Label htmlFor="confirmPassword">Confirm Password</Label>
                  <Input
                    id="confirmPassword"
                    name="confirmPassword"
                    type="password"
                    value={formData.confirmPassword}
                    onChange={handleChange}
                    className={errors.confirmPassword ? "border-red-500" : ""}
                  />
                  {errors.confirmPassword && <p className="text-sm text-red-500">{errors.confirmPassword}</p>}
                </div>

                <div className="space-y-2">
                  <Label htmlFor="role">Role</Label>
                  <Input id="role" name="role" value="Admin" disabled className="bg-gray-100" />
                </div>
              </div>
            )}
          </form>
        </CardContent>

        <CardFooter className="flex justify-between">
          {step === 1 ? (
            <>
              <div />
              <Button onClick={handleNextStep} className="group">
                Next Step
                <ArrowRight className="ml-2 h-4 w-4 transition-transform group-hover:translate-x-1" />
              </Button>
            </>
          ) : (
            <>
              <Button variant="outline" onClick={() => setStep(1)}>
                Back
              </Button>
              <Button onClick={handleSubmit}>Create Account</Button>
            </>
          )}
        </CardFooter>

        <div className="px-8 pb-8 text-center text-sm">
          Already have an account?{" "}
          <Link to="/login" className="font-medium text-primary hover:underline">
            Sign in
          </Link>
        </div>
      </Card>
    </div>
  )
}

